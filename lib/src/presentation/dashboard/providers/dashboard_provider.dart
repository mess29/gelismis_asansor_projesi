import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/data/models/daily_route_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/fault_model.dart';
import 'package:gelismis_asansor_projesi/src/core/database/database_provider.dart';
import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';

final dailyRoutesProvider = StreamProvider.autoDispose<List<DailyRouteModel>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.dailyRoutes).watch().map((routes) {
    return routes.map((r) => DailyRouteModel(
      id: r.id,
      serverId: r.serverId,
      plannerName: r.plannerName,
      plannedDate: r.plannedDate,
      status: r.status,
      isSynced: r.isSynced,
      maintenanceGroupIds: r.maintenanceGroupIds,
      completedCustomerIds: r.completedCustomerIds,
    )).where((route) => route.isVisibleOnHomeScreen || route.plannedDate.isBefore(DateTime.now())).toList();
  });
});

final activeFaultsProvider = StreamProvider.autoDispose<List<FaultModel>>((ref) {
  final db = ref.watch(databaseProvider);
  final repo = ref.watch(customerRepositoryProvider);
  
  final query = db.select(db.faults)..where((f) => f.status.equals(FaultStatus.active.index));
  return query.watch().asyncMap((faults) async {
    final results = <FaultModel>[];
    for (final f in faults) {
      final model = FaultModel(
        id: f.id,
        serverId: f.serverId,
        elevatorId: f.elevatorId,
        customerId: f.customerId,
        reportedDate: f.reportedDate,
        resolvedDate: f.resolvedDate,
        description: f.description,
        technicianNote: f.technicianNote,
        status: f.status,
      );
      if (model.customerId != null) {
        model.customer = await repo.getCustomerById(model.customerId!);
      }
      if (model.elevatorId != null) {
        model.elevator = await repo.getElevatorById(model.elevatorId!);
      }
      results.add(model);
    }
    return results;
  });
});
