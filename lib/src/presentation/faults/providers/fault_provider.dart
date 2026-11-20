import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/core/database/database_provider.dart';
import 'package:gelismis_asansor_projesi/src/core/database/app_database.dart';
import 'package:gelismis_asansor_projesi/src/data/models/fault_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/customer_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/maintenance_model.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';

final faultRepositoryProvider = Provider<FaultRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final custRepo = ref.watch(customerRepositoryProvider);
  return FaultRepository(db, custRepo);
});

final activeFaultsForElevatorProvider = FutureProvider.autoDispose.family<List<FaultModel>, int>((ref, elevatorId) async {
  final repository = ref.watch(faultRepositoryProvider);
  return repository.getActiveFaultsForElevator(elevatorId);
});

final faultHistoryForElevatorProvider = FutureProvider.autoDispose.family<List<FaultModel>, int>((ref, elevatorId) async {
  final repository = ref.watch(faultRepositoryProvider);
  return repository.getFaultHistoryForElevator(elevatorId);
});

final faultDetailProvider = FutureProvider.autoDispose.family<FaultModel?, int>((ref, faultId) async {
  final repository = ref.watch(faultRepositoryProvider);
  return repository.getFaultById(faultId);
});

class FaultRepository {
  final AppDatabase db;
  final CustomerRepository customerRepository;

  FaultRepository(this.db, this.customerRepository);

  FaultModel _map(Fault f) {
    return FaultModel(
      id: f.id,
      serverId: f.serverId,
      elevatorId: f.elevatorId,
      customerId: f.customerId,
      reportedDate: f.reportedDate,
      resolvedDate: f.resolvedDate,
      description: f.description,
      technicianNote: f.technicianNote,
      status: f.status,
      isSynced: f.isSynced,
      usedMaterials: f.usedMaterials.map((m) => UsedMaterial(
        name: m['name'],
        quantity: m['quantity'] ?? 1,
        price: (m['price'] ?? 0).toDouble(),
      )).toList(),
    );
  }

  Future<void> createFault(FaultModel fault, int customerId, int elevatorId) async {
    final customer = await customerRepository.getCustomerById(customerId);
    final elevator = await customerRepository.getElevatorById(elevatorId);
    if (customer == null || elevator == null) return;

    await db.into(db.faults).insert(FaultsCompanion(
      serverId: Value(fault.serverId),
      elevatorId: Value(elevatorId),
      customerId: Value(customerId),
      reportedDate: Value(fault.reportedDate),
      description: Value(fault.description),
      status: Value(fault.status),
    ));
  }

  Future<void> resolveFault(int faultId, String technicianNote, List<UsedMaterial> usedMaterials) async {
    await db.transaction(() async {
      final query = db.select(db.faults)..where((f) => f.id.equals(faultId));
      final faultRow = await query.getSingleOrNull();
      if (faultRow != null) {
        final uM = usedMaterials.map((m) => {
          'name': m.name,
          'quantity': m.quantity,
          'price': m.price,
        }).toList();

        await (db.update(db.faults)..where((f) => f.id.equals(faultId))).write(FaultsCompanion(
          status: const Value(FaultStatus.resolved),
          resolvedDate: Value(DateTime.now()),
          technicianNote: Value(technicianNote),
          usedMaterials: Value(uM),
        ));

        if (faultRow.customerId != null && usedMaterials.isNotEmpty) {
           final customer = await customerRepository.getCustomerById(faultRow.customerId!);
           if (customer != null) {
              double totalMaterialCost = 0.0;
              for (final material in usedMaterials) {
                 totalMaterialCost += (material.price * material.quantity);
              }
              
              if (totalMaterialCost > 0) {
                 customer.balance += totalMaterialCost;
                 final record = TransactionRecord(
                   type: TransactionType.debt,
                   date: DateTime.now(),
                   amount: totalMaterialCost,
                   description: 'Arıza Giderme - Parça Değişimi/Ek Ücret',
                 );
                 customer.transactionHistory.add(record);
                 await customerRepository.addCustomer(customer);
              }
           }
        }
      }
    });
  }

  Future<List<FaultModel>> getActiveFaultsForElevator(int elevatorId) async {
    final query = db.select(db.faults)
      ..where((f) => f.elevatorId.equals(elevatorId) & f.status.equals(FaultStatus.active.index));
    return (await query.get()).map(_map).toList();
  }

  Future<List<FaultModel>> getFaultHistoryForElevator(int elevatorId) async {
    final query = db.select(db.faults)
      ..where((f) => f.elevatorId.equals(elevatorId) & f.status.equals(FaultStatus.resolved.index))
      ..orderBy([(f) => OrderingTerm(expression: f.resolvedDate, mode: OrderingMode.desc)]);
    return (await query.get()).map(_map).toList();
  }

  Future<FaultModel?> getFaultById(int faultId) async {
    final query = db.select(db.faults)..where((f) => f.id.equals(faultId));
    final faultRow = await query.getSingleOrNull();
    if (faultRow != null) {
      final fault = _map(faultRow);
      if (fault.customerId != null) {
        fault.customer = await customerRepository.getCustomerById(fault.customerId!);
      }
      if (fault.elevatorId != null) {
        fault.elevator = await customerRepository.getElevatorById(fault.elevatorId!);
      }
      return fault;
    }
    return null;
  }
}
