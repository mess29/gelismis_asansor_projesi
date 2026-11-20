import 'customer_model.dart';
import 'elevator_model.dart';

class MaintenanceCheckItem {
  String? title;
  String? category;
  bool isChecked = false;

  MaintenanceCheckItem({this.title, this.category, this.isChecked = false});
}

class UsedMaterial {
  String? name;
  int quantity = 1;
  double price = 0.0;

  UsedMaterial({this.name, this.quantity = 1, this.price = 0.0});
}

class CarryOverNote {
  String? text;
  bool isCompleted = false;

  CarryOverNote({this.text, this.isCompleted = false});
}

class MaintenanceModel {
  int? id;
  String serverId;
  
  // Asansör ve Bina Bağlantısı
  ElevatorModel? elevator;
  int? elevatorId;
  
  CustomerModel? customer;
  int? customerId;

  // Bakım Tarihi
  DateTime maintenanceDate;
  
  // Yıl ve Ay, listeleyicilerde (Asansör Bakım Geçmişi) daha kolay gruplamak için
  int year;
  int month;

  // Bakımı Yapan Kişi (Opsiyonel / İleride eklenebilir)
  String? technicianName;
  
  // Bakım Genel Notu
  String? notes;
  
  // O bakım formundaki standart bakım check-list maddelerinin o anki durumu
  List<MaintenanceCheckItem> checklist = [];

  // O bakımdan devreden / tamamlanan görevlerin anlık görüntüsü
  List<CarryOverNote> carryOverNotes = [];

  // Bakım sırasında kullanılan malzemeler / parçalar (Fiyatlı)
  List<UsedMaterial> usedMaterials = [];

  // Senkronizasyon vb
  bool isSynced = false;
  DateTime? lastUpdatedLocal;

  MaintenanceModel({
    this.id,
    required this.serverId,
    required this.maintenanceDate,
    required this.year,
    required this.month,
    this.technicianName,
    this.notes,
    this.isSynced = false,
    this.elevatorId,
    this.elevator,
    this.customerId,
    this.customer,
    this.checklist = const [],
    this.carryOverNotes = const [],
    this.usedMaterials = const [],
  });
}
