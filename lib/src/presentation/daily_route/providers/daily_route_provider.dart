import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/core/database/database_provider.dart';
import 'package:gelismis_asansor_projesi/src/core/database/app_database.dart';
import 'package:gelismis_asansor_projesi/src/data/models/daily_route_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/customer_model.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';

final dailyRouteRepositoryProvider = Provider<DailyRouteRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final custRepo = ref.watch(customerRepositoryProvider);
  return DailyRouteRepository(db, custRepo);
});

final dailyRouteDetailProvider = FutureProvider.autoDispose.family<DailyRouteModel?, int>((ref, routeId) async {
  final repository = ref.watch(dailyRouteRepositoryProvider);
  return repository.getRouteById(routeId);
});

class DailyRouteDetailData {
  final DailyRouteModel route;
  final List<CustomerModel> pendingCustomers;
  final List<CustomerModel> completedCustomers;

  DailyRouteDetailData({
    required this.route,
    required this.pendingCustomers,
    required this.completedCustomers,
  });
}

final dailyRouteDetailCustomersProvider = FutureProvider.autoDispose.family<DailyRouteDetailData?, int>((ref, routeId) async {
  final repository = ref.watch(dailyRouteRepositoryProvider);
  final route = await repository.getRouteById(routeId);
  if (route == null) return null;

  final pending = <CustomerModel>[];
  final completed = <CustomerModel>[];

  final db = repository.db;

  for (final groupId in route.maintenanceGroupIds) {
    var group = await repository.customerRepository.getMaintenanceGroupById(groupId);
    if(group == null) continue;
    
    final queryCustomers = db.select(db.customers)..where((c) => c.maintenanceGroupId.equals(groupId));
    final customersRow = await queryCustomers.get();
    
    for (final customerRow in customersRow) {
      final customer = await repository.customerRepository.getCustomerById(customerRow.id);
      if (customer == null) continue;

      if (route.completedCustomerIds.contains(customer.id)) {
        completed.add(customer);
        continue;
      }

      if (customer.elevators.isEmpty) {
        pending.add(customer);
        continue;
      }

      bool allMaintained = true;
      for (final elevator in customer.elevators) {
        final targetYear = route.plannedDate.year;
        final targetMonth = route.plannedDate.month;

        final maintenanceCountQuery = db.select(db.maintenances)
          ..where((m) => m.elevatorId.equals(elevator.id!) & m.year.equals(targetYear) & m.month.equals(targetMonth));
        final maintenanceRes = await maintenanceCountQuery.get();

        if (maintenanceRes.isEmpty) {
          allMaintained = false;
          break;
        }
      }

      if (!allMaintained) {
        pending.add(customer);
      }
    }
  }

  return DailyRouteDetailData(
    route: route,
    pendingCustomers: pending,
    completedCustomers: completed,
  );
});

class DailyRouteRepository {
  final AppDatabase db;
  final CustomerRepository customerRepository;

  DailyRouteRepository(this.db, this.customerRepository);

  DailyRouteModel _map(DailyRoute r) {
    return DailyRouteModel(
      id: r.id,
      serverId: r.serverId,
      plannerName: r.plannerName,
      plannedDate: r.plannedDate,
      status: r.status,
      isSynced: r.isSynced,
      maintenanceGroupIds: List<int>.from(r.maintenanceGroupIds),
      completedCustomerIds: List<int>.from(r.completedCustomerIds),
    );
  }

  Future<void> createDailyRoute(DailyRouteModel route) async {
    final startOfDay = DateTime(route.plannedDate.year, route.plannedDate.month, route.plannedDate.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final existingRouteQuery = db.select(db.dailyRoutes)
      ..where((r) => r.plannedDate.isBiggerOrEqualValue(startOfDay) & r.plannedDate.isSmallerThanValue(endOfDay));
    final existingRoute = await existingRouteQuery.getSingleOrNull();

    if (existingRoute != null) {
      await db.transaction(() async {
        final newGroups = List<int>.from(existingRoute.maintenanceGroupIds);
        for (final newGroupId in route.maintenanceGroupIds) {
          if (!newGroups.contains(newGroupId)) {
            newGroups.add(newGroupId);
          }
        }
        
        var newStatus = existingRoute.status;
        if (existingRoute.status == DailyRouteStatus.completed) {
          newStatus = DailyRouteStatus.inProgress;
        }
        
        await (db.update(db.dailyRoutes)..where((r) => r.id.equals(existingRoute.id))).write(
          DailyRoutesCompanion(
            maintenanceGroupIds: Value(newGroups),
            status: Value(newStatus),
          )
        );
      });
    } else {
      await db.transaction(() async {
        await db.into(db.dailyRoutes).insert(DailyRoutesCompanion(
          serverId: Value(route.serverId),
          plannerName: Value(route.plannerName),
          plannedDate: Value(route.plannedDate),
          status: Value(route.status),
          maintenanceGroupIds: Value(route.maintenanceGroupIds),
        ));
      });
    }
  }

  Future<void> deleteDailyRoute(int id) async {
    await (db.delete(db.dailyRoutes)..where((r) => r.id.equals(id))).go();
  }

  Future<DailyRouteModel?> getRouteById(int id) async {
    final query = db.select(db.dailyRoutes)..where((r) => r.id.equals(id));
    final routeRes = await query.getSingleOrNull();
    if (routeRes != null) {
      return _map(routeRes);
    }
    return null;
  }
}
