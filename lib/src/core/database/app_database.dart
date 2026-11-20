import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:gelismis_asansor_projesi/src/data/models/elevator_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/fault_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/daily_route_model.dart';

part 'app_database.g.dart';

// --- Type Converters ---

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();
  @override
  List<String> fromSql(String fromDb) => List<String>.from(json.decode(fromDb));
  @override
  String toSql(List<String> value) => json.encode(value);
}

class IntListConverter extends TypeConverter<List<int>, String> {
  const IntListConverter();
  @override
  List<int> fromSql(String fromDb) => List<int>.from(json.decode(fromDb));
  @override
  String toSql(List<int> value) => json.encode(value);
}

class JsonListConverter extends TypeConverter<List<Map<String, dynamic>>, String> {
  const JsonListConverter();
  @override
  List<Map<String, dynamic>> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    return List<Map<String, dynamic>>.from(json.decode(fromDb));
  }
  @override
  String toSql(List<Map<String, dynamic>> value) => json.encode(value);
}

// Enums are imported from models

// --- Tables ---

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().unique()();
  TextColumn get username => text()();
  TextColumn get fullName => text()();
  TextColumn get companyName => text()();
  TextColumn get token => text().nullable()();
}

class MaintenanceGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().unique()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  TextColumn get city => text()();
  TextColumn get district => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get authorizedPerson => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get notes => text().nullable()();
  RealColumn get monthlyMaintenanceFee => real().nullable()();
  RealColumn get balance => real().withDefault(const Constant(0.0))();
  DateTimeColumn get lastFeeDate => dateTime().nullable()();
  TextColumn get transactionHistory => text().map(const JsonListConverter()).withDefault(const Constant('[]'))();
  IntColumn get maintenanceGroupId => integer().nullable().references(MaintenanceGroups, #id)();
  DateTimeColumn get lastUpdatedLocal => dateTime().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isApproved => boolean().withDefault(const Constant(false))();
}

class Elevators extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().unique()();
  TextColumn get code => text()();
  TextColumn get idNumber => text().nullable()();
  TextColumn get name => text().nullable()();
  IntColumn get type => intEnum<ElevatorType>()();
  TextColumn get usageTypeDetail => text().nullable()();
  TextColumn get driveType => text().nullable()();
  IntColumn get capacityPerson => integer().nullable()();
  IntColumn get capacityWeight => integer().nullable()();
  IntColumn get stops => integer().nullable()();
  RealColumn get speed => real().nullable()();
  IntColumn get tagColor => intEnum<ElevatorTagColor>().withDefault(const Constant(4))(); // 4 = none
  DateTimeColumn get tagDate => dateTime().nullable()();
  TextColumn get pendingMaintenanceTasks => text().map(const JsonListConverter()).withDefault(const Constant('[]'))();
  IntColumn get customerId => integer().nullable().references(Customers, #id)();
  DateTimeColumn get lastUpdatedLocal => dateTime().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isApproved => boolean().withDefault(const Constant(false))();
}

class Maintenances extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().unique()();
  IntColumn get elevatorId => integer().nullable().references(Elevators, #id)();
  IntColumn get customerId => integer().nullable().references(Customers, #id)();
  DateTimeColumn get maintenanceDate => dateTime()();
  IntColumn get year => integer()();
  IntColumn get month => integer()();
  TextColumn get technicianName => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get checklist => text().map(const JsonListConverter()).withDefault(const Constant('[]'))();
  TextColumn get carryOverNotes => text().map(const JsonListConverter()).withDefault(const Constant('[]'))();
  TextColumn get usedMaterials => text().map(const JsonListConverter()).withDefault(const Constant('[]'))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdatedLocal => dateTime().nullable()();
}

class Faults extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().unique()();
  IntColumn get elevatorId => integer().nullable().references(Elevators, #id)();
  IntColumn get customerId => integer().nullable().references(Customers, #id)();
  DateTimeColumn get reportedDate => dateTime()();
  DateTimeColumn get resolvedDate => dateTime().nullable()();
  TextColumn get description => text()();
  TextColumn get technicianNote => text().nullable()();
  IntColumn get status => intEnum<FaultStatus>()();
  TextColumn get usedMaterials => text().map(const JsonListConverter()).withDefault(const Constant('[]'))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdatedLocal => dateTime().nullable()();
}

class DailyRoutes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().unique()();
  TextColumn get plannerName => text().nullable()();
  DateTimeColumn get plannedDate => dateTime()();
  TextColumn get maintenanceGroupIds => text().map(const IntListConverter()).withDefault(const Constant('[]'))();
  IntColumn get status => intEnum<DailyRouteStatus>()();
  TextColumn get completedCustomerIds => text().map(const IntListConverter()).withDefault(const Constant('[]'))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdatedLocal => dateTime().nullable()();
}

class ServiceForms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get workOrderId => text()();
  DateTimeColumn get formStartedAt => dateTime()();
  DateTimeColumn get formCompletedAt => dateTime().nullable()();
  TextColumn get maintenanceChecklist => text().map(const JsonListConverter()).withDefault(const Constant('[]'))();
  TextColumn get technicianNotes => text().nullable()();
  TextColumn get customerSignature => text().nullable()();
}

class InventoryItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().unique()();
  TextColumn get partCode => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  IntColumn get quantityInVan => integer().withDefault(const Constant(0))();
  IntColumn get minQuantityThreshold => integer().withDefault(const Constant(1))();
  RealColumn get unitPrice => real().withDefault(const Constant(0.0))();
  TextColumn get unit => text().withDefault(const Constant('Adet'))();
}

class PartRequests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().unique()();
  IntColumn get elevatorId => integer().nullable().references(Elevators, #id)();
  IntColumn get customerId => integer().nullable().references(Customers, #id)();
  TextColumn get partName => text()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  TextColumn get urgency => text().withDefault(const Constant('Medium'))(); // Low, Medium, High, Emergency
  TextColumn get status => text().withDefault(const Constant('Pending'))(); // Pending, Approved, Dispatched, Delivered, Cancelled
  DateTimeColumn get requestedAt => dateTime()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

class ErrorCodes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get brand => text()(); // Arkel, Mikrolift, Aybey, Fuji, etc.
  TextColumn get code => text()(); // Er-01, Er-15, E-04
  TextColumn get title => text()();
  TextColumn get rootCause => text()();
  TextColumn get solutionSteps => text().map(const StringListConverter()).withDefault(const Constant('[]'))();
}

class TroubleshootingGuides extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get brand => text()();
  TextColumn get category => text()(); // Motor, Kapı, Kuyu, Kumanda Pano, Fren
  TextColumn get title => text()();
  TextColumn get symptom => text()();
  TextColumn get diagnosticSteps => text().map(const StringListConverter()).withDefault(const Constant('[]'))();
}

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get actionType => text()(); // CREATE_MAINTENANCE, UPDATE_FAULT, REQUEST_PART, SAVE_INSPECTION
  TextColumn get payloadJson => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))(); // pending, syncing, failed, completed
}

class InspectionForms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().unique()();
  IntColumn get elevatorId => integer().references(Elevators, #id)();
  IntColumn get customerId => integer().references(Customers, #id)();
  DateTimeColumn get inspectionDate => dateTime()();
  RealColumn get brakeClearanceMm => real().nullable()();
  RealColumn get cableWearPercentage => real().nullable()();
  RealColumn get safetyGearTripSpeed => real().nullable()();
  RealColumn get machineRoomTemp => real().nullable()();
  TextColumn get overallPassStatus => text().withDefault(const Constant('Pass'))(); // Pass, Warning, Fail
  TextColumn get technicianNotes => text().nullable()();
  TextColumn get customerSignature => text().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdatedLocal => dateTime().nullable()();
}

class FieldMedia extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()(); // maintenance, fault, inspection, elevator
  IntColumn get entityId => integer()();
  TextColumn get mediaType => text()(); // photo, voice_note
  TextColumn get filePath => text()();
  TextColumn get caption => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [
  Users,
  Customers,
  Elevators,
  Maintenances,
  Faults,
  DailyRoutes,
  MaintenanceGroups,
  ServiceForms,
  InventoryItems,
  PartRequests,
  ErrorCodes,
  TroubleshootingGuides,
  SyncQueue,
  InspectionForms,
  FieldMedia,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(inventoryItems);
            await m.createTable(partRequests);
            await m.createTable(errorCodes);
            await m.createTable(troubleshootingGuides);
            await m.createTable(syncQueue);
            await m.createTable(inspectionForms);
            await m.createTable(fieldMedia);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
