class ChecklistItem {
  String? key;
  String? label;
  bool? isChecked;
  String? category;
  
  ChecklistItem({this.key, this.label, this.isChecked, this.category});
}

class ServiceFormModel {
  int? id;

  // Hangi iş emrine ait olduğunu belirtir
  String workOrderId;

  DateTime formStartedAt;
  DateTime? formCompletedAt;

  // JSON olarak saklamak yerine, gömülü nesnelerle daha verimli (şimdi Drift için dönüştürüldü)
  List<ChecklistItem> maintenanceChecklist = [];

  String? technicianNotes;

  String? customerSignature; // Base64 formatında imza verisi
  
  ServiceFormModel({
    this.id,
    required this.workOrderId,
    required this.formStartedAt,
    this.formCompletedAt,
    this.maintenanceChecklist = const [],
    this.technicianNotes,
    this.customerSignature,
  });
}