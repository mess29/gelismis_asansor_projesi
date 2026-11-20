import 'elevator_model.dart';
import 'maintenance_group_model.dart';

enum TransactionType {
  debt, // Borç (Aidat, Asansör Parçası vb.)
  payment, // Alacak / Tahsilat
}

class TransactionRecord {
  String? id; // Yerel tanımlayıcı (düzenleme/silme için)
  TransactionType type;
  DateTime? date;
  double? amount;
  String? description;

  TransactionRecord({this.id, this.type = TransactionType.debt, this.date, this.amount, this.description}) {
    id ??= DateTime.now().microsecondsSinceEpoch.toString();
  }
}

class CustomerModel {
  int? id;
  String serverId; // CRM ID

  String name; // Apartman adı (Çınar Apt.) veya Kişi adı
  String address; // Açık adres
  String city;
  String district;

  double? latitude; // Harita için
  double? longitude;

  String? authorizedPerson; // Yönetici adı
  String? phone; // Yönetici telefonu
  
  String? notes; // Notlar
  double? monthlyMaintenanceFee; // Aylık Bakım Ücreti
  double balance = 0.0; // Bakiye (Borç/Alacak)
  DateTime? lastFeeDate; // Son aidat işleme tarihi

  // Cari işlem (borç / alacak) geçmişi
  List<TransactionRecord> transactionHistory = [];

  // Asansörlerle ilişki
  List<ElevatorModel> elevators = [];

  // Bakım Grubu / Bölgesi
  MaintenanceGroupModel? maintenanceGroup;
  int? maintenanceGroupId; // Foreign key helper

  DateTime? lastUpdatedLocal;
  bool isSynced = false;
  bool isApproved = false; // Admin onayı

  CustomerModel({
    this.id,
    required this.serverId,
    required this.name,
    required this.address,
    required this.city,
    required this.district,
    this.latitude,
    this.longitude,
    this.authorizedPerson,
    this.phone,
    this.notes,
    this.monthlyMaintenanceFee,
    this.balance = 0.0,
    this.lastFeeDate,
    this.isSynced = false,
    this.isApproved = false,
    this.transactionHistory = const [],
    this.maintenanceGroupId,
    this.maintenanceGroup,
    this.elevators = const [],
  });
}
