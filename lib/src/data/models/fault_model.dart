import 'elevator_model.dart';
import 'customer_model.dart';
import 'maintenance_model.dart';

enum FaultStatus {
  active,
  resolved,
}

class FaultModel {
  int? id;
  String serverId;

  // Asansör ve Bina Bağlantısı
  ElevatorModel? elevator;
  int? elevatorId;

  CustomerModel? customer;
  int? customerId;

  // Arıza Tarihleri
  DateTime reportedDate; // Bildirim tarihi
  DateTime? resolvedDate;     // Giderilme tarihi

  // Tanım ve Çözüm Notu
  String description;
  String? technicianNote;

  FaultStatus status;

  // Bakım başlat bölümüyle aynı parça değişimi / kullanılan malzemeler
  List<UsedMaterial> usedMaterials = [];

  bool isSynced = false;
  DateTime? lastUpdatedLocal;

  FaultModel({
    this.id,
    required this.serverId,
    required this.reportedDate,
    required this.description,
    required this.status,
    this.resolvedDate,
    this.technicianNote,
    this.isSynced = false,
    this.elevatorId,
    this.elevator,
    this.customerId,
    this.customer,
    this.usedMaterials = const [],
  });
}
