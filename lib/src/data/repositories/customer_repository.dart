import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/data/models/elevator_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/customer_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/maintenance_group_model.dart';
import 'package:gelismis_asansor_projesi/src/core/database/database_provider.dart';
import 'package:gelismis_asansor_projesi/src/core/database/app_database.dart';
import 'package:drift/drift.dart' hide Column;

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return CustomerRepository(db);
});

enum SortField { name, city, district, date }
enum SortOrder { asc, desc }
enum MaintenanceGroupSort { nameAsc, nameDesc }

class CustomerFilter {
  final String query;
  final String? city;
  final String? district;
  final SortField sortField;
  final SortOrder sortOrder;

  CustomerFilter({
    this.query = '', 
    this.city, 
    this.district,
    this.sortField = SortField.name,
    this.sortOrder = SortOrder.asc,
  });

  CustomerFilter copyWith({
    String? query, 
    String? city, 
    String? district,
    SortField? sortField,
    SortOrder? sortOrder,
  }) {
    return CustomerFilter(
      query: query ?? this.query,
      city: city ?? this.city,
      district: district ?? this.district,
      sortField: sortField ?? this.sortField,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}

final customerFilterProvider = StateProvider<CustomerFilter>((ref) => CustomerFilter());

final customerListProvider = FutureProvider.autoDispose<List<CustomerModel>>((ref) async {
  final repository = ref.watch(customerRepositoryProvider);
  final filter = ref.watch(customerFilterProvider);
  return repository.getCustomers(filter);
});

final customerDetailProvider = FutureProvider.autoDispose.family<CustomerModel?, int>((ref, id) async {
  final repository = ref.watch(customerRepositoryProvider);
  return repository.getCustomerById(id);
});

final datetimeProvider = Provider<DateTime>((ref) => DateTime.now());

final expiringElevatorsProvider = FutureProvider.autoDispose<List<ElevatorModel>>((ref) async {
  final repository = ref.watch(customerRepositoryProvider);
  return repository.getExpiringElevators();
});

class CustomerRepository {
  final AppDatabase db;

  CustomerRepository(this.db);

  CustomerModel _mapCustomer(Customer c) {
    final history = c.transactionHistory.map((m) => TransactionRecord(
      id: m['id'],
      type: TransactionType.values.firstWhere((e) => e.toString() == 'TransactionType.${m['type']}', orElse: () => TransactionType.debt),
      date: m['date'] != null ? DateTime.parse(m['date']) : null,
      amount: m['amount'],
      description: m['description']
    )).toList();

    return CustomerModel(
      id: c.id,
      serverId: c.serverId,
      name: c.name,
      address: c.address,
      city: c.city,
      district: c.district,
      latitude: c.latitude,
      longitude: c.longitude,
      authorizedPerson: c.authorizedPerson,
      phone: c.phone,
      notes: c.notes,
      monthlyMaintenanceFee: c.monthlyMaintenanceFee,
      balance: c.balance,
      lastFeeDate: c.lastFeeDate,
      isSynced: c.isSynced,
      isApproved: c.isApproved,
      transactionHistory: history,
      maintenanceGroupId: c.maintenanceGroupId,
    );
  }

  ElevatorModel _mapElevator(Elevator e) {
    final tasks = e.pendingMaintenanceTasks.map((t) => TickableNote(
      text: t['text'],
      isChecked: t['isChecked'] ?? false,
    )).toList();

    return ElevatorModel(
      id: e.id,
      serverId: e.serverId,
      code: e.code,
      idNumber: e.idNumber,
      name: e.name,
      type: e.type,
      usageTypeDetail: e.usageTypeDetail,
      driveType: e.driveType,
      capacityPerson: e.capacityPerson,
      capacityWeight: e.capacityWeight,
      stops: e.stops,
      speed: e.speed,
      tagColor: e.tagColor,
      tagDate: e.tagDate,
      isSynced: e.isSynced,
      isApproved: e.isApproved,
      customerId: e.customerId,
      pendingMaintenanceTasks: tasks,
    );
  }

  MaintenanceGroupModel _mapGroup(MaintenanceGroup g) {
    return MaintenanceGroupModel(
      id: g.id,
      name: g.name,
    );
  }

  Future<List<CustomerModel>> getCustomers(CustomerFilter filter) async {
    var query = db.select(db.customers);
    
    if (filter.query.isNotEmpty) {
      final qParam = '%${filter.query}%';
      query.where((c) => c.name.like(qParam) | c.address.like(qParam));
    }
    if (filter.city != null && filter.city!.isNotEmpty) {
      query.where((c) => c.city.equals(filter.city!));
    }
    if (filter.district != null && filter.district!.isNotEmpty) {
      query.where((c) => c.district.equals(filter.district!));
    }

    if (filter.sortField == SortField.name) {
      query.orderBy([(c) => OrderingTerm(expression: c.name, mode: filter.sortOrder == SortOrder.asc ? OrderingMode.asc : OrderingMode.desc)]);
    } else if (filter.sortField == SortField.city) {
      query.orderBy([
        (c) => OrderingTerm(expression: c.city, mode: filter.sortOrder == SortOrder.asc ? OrderingMode.asc : OrderingMode.desc),
        (c) => OrderingTerm(expression: c.name, mode: filter.sortOrder == SortOrder.asc ? OrderingMode.asc : OrderingMode.desc)
      ]);
    } else if (filter.sortField == SortField.district) {
      query.orderBy([
        (c) => OrderingTerm(expression: c.district, mode: filter.sortOrder == SortOrder.asc ? OrderingMode.asc : OrderingMode.desc),
        (c) => OrderingTerm(expression: c.name, mode: filter.sortOrder == SortOrder.asc ? OrderingMode.asc : OrderingMode.desc)
      ]);
    } else {
      query.orderBy([(c) => OrderingTerm(expression: c.id, mode: filter.sortOrder == SortOrder.asc ? OrderingMode.asc : OrderingMode.desc)]);
    }

    final data = await query.get();
    final results = data.map(_mapCustomer).toList();

    for (var c in results) {
      if (c.maintenanceGroupId != null) {
        c.maintenanceGroup = await getMaintenanceGroupById(c.maintenanceGroupId!);
      }
    }
    return results;
  }

  Future<CustomerModel?> getCustomerById(int id) async {
    final query = db.select(db.customers)..where((c) => c.id.equals(id));
    final result = await query.getSingleOrNull();
    if (result == null) return null;
    
    final customer = _mapCustomer(result);
    final elevatorsQuery = db.select(db.elevators)..where((e) => e.customerId.equals(id));
    final elevData = await elevatorsQuery.get();
    customer.elevators = elevData.map(_mapElevator).toList();
    
    if (customer.maintenanceGroupId != null) {
      customer.maintenanceGroup = await getMaintenanceGroupById(customer.maintenanceGroupId!);
    }
    
    return customer;
  }

  Future<ElevatorModel?> getElevatorById(int id) async {
    final query = db.select(db.elevators)..where((e) => e.id.equals(id));
    final result = await query.getSingleOrNull();
    if (result == null) return null;
    return _mapElevator(result);
  }

  Future<List<ElevatorModel>> getExpiringElevators() async {
    final query = db.select(db.elevators)..where((e) => e.tagColor.isNotValue(ElevatorTagColor.none.index));
    final elevators = (await query.get()).map(_mapElevator).toList();
    
    for (var e in elevators) {
      if (e.customerId != null) {
        e.customer = await getCustomerById(e.customerId!);
      }
    }

    final expiring = elevators.where((e) {
      final remaining = e.remainingDays;
      if (remaining == null) return false;
      return remaining <= 15;
    }).toList();

    expiring.sort((a, b) => (a.remainingDays ?? 999).compareTo(b.remainingDays ?? 999));
    return expiring;
  }

  Future<int> addCustomer(CustomerModel customer, {MaintenanceGroupModel? group}) async {
    final historyList = customer.transactionHistory.map((t) => {
      'id': t.id,
      'type': t.type.name,
      'date': t.date?.toIso8601String(),
      'amount': t.amount,
      'description': t.description,
    }).toList();

    final companion = CustomersCompanion(
      serverId: Value(customer.serverId),
      name: Value(customer.name),
      address: Value(customer.address),
      city: Value(customer.city),
      district: Value(customer.district),
      latitude: Value(customer.latitude),
      longitude: Value(customer.longitude),
      authorizedPerson: Value(customer.authorizedPerson),
      phone: Value(customer.phone),
      notes: Value(customer.notes),
      monthlyMaintenanceFee: Value(customer.monthlyMaintenanceFee),
      balance: Value(customer.balance),
      lastFeeDate: Value(customer.lastFeeDate),
      transactionHistory: Value(historyList),
      maintenanceGroupId: Value(group?.id ?? customer.maintenanceGroupId),
    );

    if (customer.id != null) {
      await (db.update(db.customers)..where((c) => c.id.equals(customer.id!))).write(companion);
      return customer.id!;
    } else {
      return await db.into(db.customers).insert(companion);
    }
  }

  Future<void> addElevator(ElevatorModel elevator, {CustomerModel? customer}) async {
    final tasksList = elevator.pendingMaintenanceTasks.map((t) => {
      'text': t.text,
      'isChecked': t.isChecked,
    }).toList();

    final companion = ElevatorsCompanion(
      serverId: Value(elevator.serverId),
      code: Value(elevator.code),
      idNumber: Value(elevator.idNumber),
      name: Value(elevator.name),
      type: Value(elevator.type),
      usageTypeDetail: Value(elevator.usageTypeDetail),
      driveType: Value(elevator.driveType),
      capacityPerson: Value(elevator.capacityPerson),
      capacityWeight: Value(elevator.capacityWeight),
      stops: Value(elevator.stops),
      speed: Value(elevator.speed),
      tagColor: Value(elevator.tagColor),
      tagDate: Value(elevator.tagDate),
      customerId: Value(customer?.id ?? elevator.customerId),
      pendingMaintenanceTasks: Value(tasksList),
    );

    if (elevator.id != null) {
      await (db.update(db.elevators)..where((e) => e.id.equals(elevator.id!))).write(companion);
    } else {
      await db.into(db.elevators).insert(companion);
    }
  }

  Future<void> deleteCustomer(int id) async {
    await db.transaction(() async {
      await (db.delete(db.elevators)..where((e) => e.customerId.equals(id))).go();
      await (db.delete(db.customers)..where((c) => c.id.equals(id))).go();
    });
  }

  Future<void> deleteElevator(int elevatorId) async {
    await (db.delete(db.elevators)..where((e) => e.id.equals(elevatorId))).go();
  }

  Future<void> checkAndApplyMonthlyFees() async {
    final query = db.select(db.customers);
    final customers = await query.get();
    final now = DateTime.now();

    await db.transaction(() async {
      for (final c in customers) {
        if (c.monthlyMaintenanceFee == null || c.monthlyMaintenanceFee! <= 0) continue;

        var lastFeeDate = c.lastFeeDate;
        var balance = c.balance;
        var historyMap = List<Map<String,dynamic>>.from(c.transactionHistory);
        
        if (lastFeeDate == null) {
          await (db.update(db.customers)..where((tbl) => tbl.id.equals(c.id))).write(
            CustomersCompanion(lastFeeDate: Value(DateTime(now.year, now.month, 1)))
          );
          continue;
        }

        int monthsToAdd = 0;
        DateTime tempDate = DateTime(lastFeeDate.year, lastFeeDate.month + 1, 1);
        
        while (tempDate.isBefore(now) || tempDate.isAtSameMomentAs(now)) {
           monthsToAdd++;
           historyMap.add({
             'id': DateTime.now().microsecondsSinceEpoch.toString(),
             'type': TransactionType.debt.name,
             'date': tempDate.toIso8601String(),
             'amount': c.monthlyMaintenanceFee,
             'description': '${_getMonthName(tempDate.month)} ${tempDate.year} Aidatı'
           });
           tempDate = DateTime(tempDate.year, tempDate.month + 1, 1);
        }

        if (monthsToAdd > 0) {
          balance += (c.monthlyMaintenanceFee! * monthsToAdd);
          lastFeeDate = DateTime(tempDate.year, tempDate.month - 1, 1);
          await (db.update(db.customers)..where((tbl) => tbl.id.equals(c.id))).write(
            CustomersCompanion(
              lastFeeDate: Value(lastFeeDate),
              balance: Value(balance),
              transactionHistory: Value(historyMap)
            )
          );
        }
      }
    });
  }

  String _getMonthName(int month) {
    const months = ['', 'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran', 'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'];
    if (month >= 1 && month <= 12) return months[month];
    return month.toString();
  }

  Future<void> addPayment(int customerId, double amount, String description) async {
    final customer = await getCustomerById(customerId);
    if (customer == null) return;

    customer.balance -= amount;
    customer.transactionHistory.add(TransactionRecord(
      type: TransactionType.payment,
      date: DateTime.now(),
      amount: amount,
      description: description,
    ));

    await addCustomer(customer);
  }

  Future<void> updateTransaction(int customerId, String transactionId, double newAmount, String newDescription) async {
    final customer = await getCustomerById(customerId);
    if (customer == null) return;

    final index = customer.transactionHistory.indexWhere((t) => t.id == transactionId);
    if (index == -1) return;

    final oldRecord = customer.transactionHistory[index];
    
    if (oldRecord.type == TransactionType.payment) {
      customer.balance += (oldRecord.amount ?? 0);
      customer.balance -= newAmount;
    } else {
      customer.balance -= (oldRecord.amount ?? 0);
      customer.balance += newAmount;
    }

    oldRecord.amount = newAmount;
    oldRecord.description = newDescription;
    
    await addCustomer(customer);
  }

  Future<void> deleteTransaction(int customerId, String transactionId) async {
    final customer = await getCustomerById(customerId);
    if (customer == null) return;

    final index = customer.transactionHistory.indexWhere((t) => t.id == transactionId);
    if (index == -1) return;

    final oldRecord = customer.transactionHistory[index];

    if (oldRecord.type == TransactionType.payment) {
      customer.balance += (oldRecord.amount ?? 0);
    } else {
      customer.balance -= (oldRecord.amount ?? 0);
    }

    customer.transactionHistory.removeAt(index);
    await addCustomer(customer);
  }

  Future<int> createMaintenanceGroup(String name) async {
    return await db.into(db.maintenanceGroups).insert(MaintenanceGroupsCompanion(name: Value(name)));
  }

  Future<List<MaintenanceGroupModel>> getMaintenanceGroups({MaintenanceGroupSort sort = MaintenanceGroupSort.nameAsc}) async {
    var query = db.select(db.maintenanceGroups);
    if (sort == MaintenanceGroupSort.nameAsc) {
      query.orderBy([(g) => OrderingTerm(expression: g.name, mode: OrderingMode.asc)]);
    } else {
      query.orderBy([(g) => OrderingTerm(expression: g.name, mode: OrderingMode.desc)]);
    }
    return (await query.get()).map(_mapGroup).toList();
  }

  Future<MaintenanceGroupModel?> getMaintenanceGroupById(int id) async {
    final query = db.select(db.maintenanceGroups)..where((g) => g.id.equals(id));
    final res = await query.getSingleOrNull();
    return res != null ? _mapGroup(res) : null;
  }

  Future<void> deleteMaintenanceGroup(int id) async {
    await db.transaction(() async {
      await (db.update(db.customers)..where((c) => c.maintenanceGroupId.equals(id))).write(
        const CustomersCompanion(maintenanceGroupId: Value(null))
      );
      await (db.delete(db.maintenanceGroups)..where((g) => g.id.equals(id))).go();
    });
  }

  Future<List<CustomerModel>> getAvailableCustomers() async {
    final query = db.select(db.customers)..where((c) => c.maintenanceGroupId.isNull());
    return (await query.get()).map(_mapCustomer).toList();
  }

  Future<void> assignCustomersToGroup(int groupId, List<int> customerIds) async {
    await db.transaction(() async {
      for (final customerId in customerIds) {
        await (db.update(db.customers)..where((c) => c.id.equals(customerId))).write(
          CustomersCompanion(maintenanceGroupId: Value(groupId))
        );
      }
    });
  }

  Future<void> removeCustomerFromGroup(int customerId) async {
    await (db.update(db.customers)..where((c) => c.id.equals(customerId))).write(
      const CustomersCompanion(maintenanceGroupId: Value(null))
    );
  }
}
