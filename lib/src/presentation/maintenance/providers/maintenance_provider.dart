import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/core/database/database_provider.dart';
import 'package:gelismis_asansor_projesi/src/core/database/app_database.dart';
import 'package:gelismis_asansor_projesi/src/data/models/maintenance_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/elevator_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/customer_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/daily_route_model.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';

final maintenanceRepositoryProvider = Provider<MaintenanceRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final custRepo = ref.watch(customerRepositoryProvider);
  return MaintenanceRepository(db, custRepo);
});

final maintenanceHistoryForElevatorProvider = FutureProvider.autoDispose.family<List<MaintenanceModel>, int>((ref, elevatorId) async {
  final repository = ref.watch(maintenanceRepositoryProvider);
  return repository.getMaintenanceHistoryForElevator(elevatorId);
});

class MaintenanceRepository {
  final AppDatabase db;
  final CustomerRepository customerRepository;

  MaintenanceRepository(this.db, this.customerRepository);

  Future<void> saveMaintenanceRecord(MaintenanceModel maintenance, int customerId, int elevatorId, List<TickableNote> newPendingTasks) async {
    await db.transaction(() async {
      final customer = await customerRepository.getCustomerById(customerId);
      final elevator = await customerRepository.getElevatorById(elevatorId);
      if (customer == null || elevator == null) return;

      final checklistMap = maintenance.checklist.map((c) => {
        'title': c.title,
        'category': c.category,
        'isChecked': c.isChecked
      }).toList();

      final carryOverNotesMap = maintenance.carryOverNotes.map((c) => {
        'text': c.text,
        'isCompleted': c.isCompleted,
      }).toList();

      final usedMaterialsMap = maintenance.usedMaterials.map((m) => {
        'name': m.name,
        'quantity': m.quantity,
        'price': m.price,
      }).toList();

      maintenance.elevatorId = elevatorId;
      maintenance.customerId = customerId;

      await db.into(db.maintenances).insert(MaintenancesCompanion(
        serverId: Value(maintenance.serverId),
        elevatorId: Value(elevatorId),
        customerId: Value(customerId),
        maintenanceDate: Value(maintenance.maintenanceDate),
        year: Value(maintenance.year),
        month: Value(maintenance.month),
        technicianName: Value(maintenance.technicianName),
        notes: Value(maintenance.notes),
        checklist: Value(checklistMap),
        carryOverNotes: Value(carryOverNotesMap),
        usedMaterials: Value(usedMaterialsMap),
        isSynced: Value(maintenance.isSynced),
      ));

      elevator.pendingMaintenanceTasks = newPendingTasks;
      await customerRepository.addElevator(elevator, customer: customer);

      if (maintenance.usedMaterials.isNotEmpty) {
        double totalMaterialCost = 0.0;
        for (final material in maintenance.usedMaterials) {
           totalMaterialCost += (material.price * material.quantity);
        }
        
        if (totalMaterialCost > 0) {
           customer.balance += totalMaterialCost; 
           final record = TransactionRecord(
             type: TransactionType.debt,
             date: DateTime.now(),
             amount: totalMaterialCost,
             description: 'Asansör Bakımı - Parça Değişim / Ek Ücreti',
           );
           customer.transactionHistory.add(record);
           await customerRepository.addCustomer(customer);
        }
      }

      final pendingRoutesQuery = db.select(db.dailyRoutes)..where((r) => r.status.isNotValue(DailyRouteStatus.completed.index));
      final pendingRoutes = await pendingRoutesQuery.get();

      for (final routeRow in pendingRoutes) {
        final completedCustomerIds = List<int>.from(routeRow.completedCustomerIds);
        if (!completedCustomerIds.contains(customerId)) {
           bool isCustomerInRoute = false;
           int totalCustomers = 0;

           for (final groupId in routeRow.maintenanceGroupIds) {
             final tGroupQuery = db.select(db.customers)..where((c) => c.maintenanceGroupId.equals(groupId));
             final tGroupCustomers = await tGroupQuery.get();
             totalCustomers += tGroupCustomers.length;
             if (tGroupCustomers.any((c) => c.id == customerId)) {
               isCustomerInRoute = true;
             }
           }

           if (isCustomerInRoute) {
             completedCustomerIds.add(customerId);
             var newStatus = DailyRouteStatus.inProgress;
             if (completedCustomerIds.length >= totalCustomers && totalCustomers > 0) {
                newStatus = DailyRouteStatus.completed;
             }

             await (db.update(db.dailyRoutes)..where((r) => r.id.equals(routeRow.id))).write(
               DailyRoutesCompanion(
                 completedCustomerIds: Value(completedCustomerIds),
                 status: Value(newStatus),
               )
             );
           }
        }
      }
    });
  }

  Future<List<MaintenanceModel>> getMaintenanceHistoryForElevator(int elevatorId) async {
    final query = db.select(db.maintenances)
      ..where((m) => m.elevatorId.equals(elevatorId))
      ..orderBy([(m) => OrderingTerm(expression: m.maintenanceDate, mode: OrderingMode.desc)]);
      
    final results = await query.get();

    return results.map((m) {
       final checklist = m.checklist.map((c) => MaintenanceCheckItem(
          title: c['title'], category: c['category'], isChecked: c['isChecked'] ?? false
       )).toList();
       final carryOverNotes = m.carryOverNotes.map((c) => CarryOverNote(
          text: c['text'], isCompleted: c['isCompleted'] ?? false
       )).toList();
       final usedMaterials = m.usedMaterials.map((c) => UsedMaterial(
          name: c['name'], quantity: c['quantity'] ?? 1, price: (c['price'] ?? 0).toDouble()
       )).toList();

       return MaintenanceModel(
         id: m.id,
         serverId: m.serverId,
         elevatorId: m.elevatorId,
         customerId: m.customerId,
         maintenanceDate: m.maintenanceDate,
         year: m.year,
         month: m.month,
         technicianName: m.technicianName,
         notes: m.notes,
         checklist: checklist,
         carryOverNotes: carryOverNotes,
         usedMaterials: usedMaterials,
         isSynced: m.isSynced,
       );
    }).toList();
  }
}
