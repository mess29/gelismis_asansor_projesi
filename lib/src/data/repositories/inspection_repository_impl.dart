import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/core/database/app_database.dart';
import 'package:gelismis_asansor_projesi/src/core/database/database_provider.dart';
import 'package:gelismis_asansor_projesi/src/core/sync/sync_manager.dart';
import 'package:gelismis_asansor_projesi/src/data/models/inspection_form_model.dart';
import 'package:gelismis_asansor_projesi/src/domain/repositories/inspection_repository.dart';

final inspectionRepositoryProvider = Provider<InspectionRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final syncManager = ref.watch(syncManagerProvider);
  return InspectionRepositoryImpl(db, syncManager);
});

class InspectionRepositoryImpl implements InspectionRepository {
  final AppDatabase db;
  final SyncManager syncManager;

  InspectionRepositoryImpl(this.db, this.syncManager);

  @override
  Future<List<InspectionFormModel>> getInspectionsForElevator(int elevatorId) async {
    final rows = await (db.select(db.inspectionForms)
      ..where((t) => t.elevatorId.equals(elevatorId))
      ..orderBy([(t) => OrderingTerm(expression: t.inspectionDate, mode: OrderingMode.desc)]))
      .get();

    return rows.map((r) => InspectionFormModel(
      id: r.id,
      serverId: r.serverId,
      elevatorId: r.elevatorId,
      customerId: r.customerId,
      inspectionDate: r.inspectionDate,
      brakeClearanceMm: r.brakeClearanceMm,
      cableWearPercentage: r.cableWearPercentage,
      safetyGearTripSpeed: r.safetyGearTripSpeed,
      machineRoomTemp: r.machineRoomTemp,
      overallPassStatus: r.overallPassStatus,
      technicianNotes: r.technicianNotes,
      customerSignature: r.customerSignature,
      isSynced: r.isSynced,
      lastUpdatedLocal: r.lastUpdatedLocal,
    )).toList();
  }

  @override
  Future<void> saveInspection(InspectionFormModel form) async {
    await db.into(db.inspectionForms).insert(
      InspectionFormsCompanion.insert(
        serverId: form.serverId,
        elevatorId: form.elevatorId,
        customerId: form.customerId,
        inspectionDate: form.inspectionDate,
        brakeClearanceMm: Value(form.brakeClearanceMm),
        cableWearPercentage: Value(form.cableWearPercentage),
        safetyGearTripSpeed: Value(form.safetyGearTripSpeed),
        machineRoomTemp: Value(form.machineRoomTemp),
        overallPassStatus: Value(form.overallPassStatus),
        technicianNotes: Value(form.technicianNotes),
        customerSignature: Value(form.customerSignature),
        isSynced: Value(form.isSynced),
        lastUpdatedLocal: Value(DateTime.now()),
      ),
    );

    // Queue mutation for background sync
    await syncManager.addToQueue('SAVE_INSPECTION', {
      'serverId': form.serverId,
      'elevatorId': form.elevatorId,
      'customerId': form.customerId,
      'inspectionDate': form.inspectionDate.toIso8601String(),
      'passStatus': form.overallPassStatus,
      'brakeClearanceMm': form.brakeClearanceMm,
      'cableWearPercentage': form.cableWearPercentage,
    });
  }
}
