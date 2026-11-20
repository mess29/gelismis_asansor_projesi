import 'customer_model.dart';

enum ElevatorType {
  human, // İnsan
  freight, // Yük
  stretcher, // Sedye
  moncharge, // Monşarj
  vehicle, // Araç
  service, // Servis
  disabled, // Engelli
  platform, // Platform
  other, // Diğer
}

enum ElevatorTagColor {
  red,    // 60 gün
  yellow, // 120 gün
  blue,   // 365 gün
  green,  // 365 gün
  none,   // Etiketsiz
}

class TickableNote {
  String? text;
  bool isChecked = false;
  TickableNote({this.text, this.isChecked = false});
}

class ElevatorModel {
  int? id;
  String serverId; 

  String code; // Asansör Seri No (Etiket Kodu)
  String? idNumber; // Asansör Kimlik Numarası (Örn: 123456/01)
  String? name; // Bina İçi Adı (Örn: A Blok Asansörü)
  
  ElevatorType type;
  String? usageTypeDetail; // Tip 'Diğer' ise detay

  String? driveType; // Elektrik / Hidrolik

  int? capacityPerson;
  int? capacityWeight;
  int? stops;
  double? speed;

  // Yeni Etiket Sistemi
  ElevatorTagColor tagColor; 
  DateTime? tagDate; // Etiketin alındığı / revize edildiği tarih

  // Devreden bakım notları (ör: Parça değişimi, kalıcı görevler)
  List<TickableNote> pendingMaintenanceTasks = [];

  // Hangi müşteriye ait?
  CustomerModel? customer;
  int? customerId;

  DateTime? lastUpdatedLocal;
  bool isSynced = false;
  bool isApproved = false;

  ElevatorModel({
    this.id,
    required this.serverId,
    required this.code,
    this.idNumber,
    this.name,
    required this.type,
    this.usageTypeDetail,
    this.driveType,
    this.capacityPerson,
    this.capacityWeight,
    this.stops,
    this.speed,
    this.tagColor = ElevatorTagColor.none,
    this.tagDate,
    this.isSynced = false,
    this.isApproved = false,
    this.customerId,
    this.customer,
    this.pendingMaintenanceTasks = const [],
  });

  // Etiket süresi hesaplama yardımcısı
  int get expiryDays {
    switch (tagColor) {
      case ElevatorTagColor.red:
        return 60;
      case ElevatorTagColor.yellow:
        return 120;
      case ElevatorTagColor.blue:
      case ElevatorTagColor.green:
        return 365;
      case ElevatorTagColor.none:
        return 0; // Süresiz / Geçersiz
    }
  }

  // Kalan gün sayısını hesaplayan yardımcı (Eğer tagDate varsa ve etiket none değilse)
  int? get remainingDays {
    if (tagDate == null || tagColor == ElevatorTagColor.none) return null;
    final expiryDate = tagDate!.add(Duration(days: expiryDays));
    return expiryDate.difference(DateTime.now()).inDays;
  }
}
