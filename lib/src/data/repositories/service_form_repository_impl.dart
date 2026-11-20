import 'package:gelismis_asansor_projesi/src/data/models/service_form_model.dart';
import 'package:gelismis_asansor_projesi/src/domain/repositories/service_form_repository.dart';
import 'package:gelismis_asansor_projesi/src/core/database/app_database.dart';
import 'package:drift/drift.dart' hide Column;

class ServiceFormRepositoryImpl implements ServiceFormRepository {
  final AppDatabase db;
  
  ServiceFormRepositoryImpl(this.db);

  ServiceFormModel _map(ServiceForm f) {
    final list = f.maintenanceChecklist.map((c) => ChecklistItem(
      key: c['key'],
      label: c['label'],
      isChecked: c['isChecked'],
      category: c['category']
    )).toList();

    return ServiceFormModel(
      id: f.id,
      workOrderId: f.workOrderId,
      formStartedAt: f.formStartedAt,
      formCompletedAt: f.formCompletedAt,
      maintenanceChecklist: list,
      technicianNotes: f.technicianNotes,
      customerSignature: f.customerSignature,
    );
  }

  @override
  Future<ServiceFormModel?> getForm(String workOrderId) async {
    final query = db.select(db.serviceForms)..where((f) => f.workOrderId.equals(workOrderId));
    final res = await query.getSingleOrNull();
    return res != null ? _map(res) : null;
  }

  @override
  Future<void> saveForm(ServiceFormModel form) async {
    final chkMap = form.maintenanceChecklist.map((c) => {
      'key': c.key,
      'label': c.label,
      'isChecked': c.isChecked,
      'category': c.category
    }).toList();

    final companion = ServiceFormsCompanion(
      workOrderId: Value(form.workOrderId),
      formStartedAt: Value(form.formStartedAt),
      formCompletedAt: Value(form.formCompletedAt),
      maintenanceChecklist: Value(chkMap),
      technicianNotes: Value(form.technicianNotes),
      customerSignature: Value(form.customerSignature),
    );

    if (form.id != null) {
      await (db.update(db.serviceForms)..where((f) => f.id.equals(form.id!))).write(companion);
    } else {
      await db.into(db.serviceForms).insert(companion);
    }
  }
}