import 'maintenance_group_model.dart';

enum DailyRouteStatus {
  pending,
  inProgress,
  completed,
}

class DailyRouteModel {
  int? id;
  String serverId;

  // Rotayı kimin / kim için oluşturduğu
  String? plannerName;
  
  // Planlanan tarih. (Örn: yarın için planlandıysa yarının tarihi)
  DateTime plannedDate;

  // Bu rotada seçilen bölgeler
  List<MaintenanceGroupModel> maintenanceGroups = [];
  List<int> maintenanceGroupIds = [];

  DailyRouteStatus status;

  // Hangi binaların/müşterilerin bakımı bu rotada tamamlandı
  List<int> completedCustomerIds = [];

  bool isSynced = false;
  DateTime? lastUpdatedLocal;

  DailyRouteModel({
    this.id,
    required this.serverId,
    required this.plannedDate,
    required this.status,
    this.plannerName,
    this.isSynced = false,
    this.maintenanceGroups = const [],
    this.maintenanceGroupIds = const [],
    this.completedCustomerIds = const [],
  });

  // Kural: "planlanan günden önceki gün saat 16:00'dan sonra ana ekranda gösterebilmeli."
  // Yardımcı getter:
  bool get isVisibleOnHomeScreen {
    final now = DateTime.now();
    // Eğer rota bugüne veya geleceğe aitse doğrudan göster
    if (plannedDate.isAfter(DateTime(now.year, now.month, now.day - 1))) {
      return true;
    }
    // Planlanan tarihin bir gün öncesi, saat 16:00
    final showAfter = DateTime(
      plannedDate.year,
      plannedDate.month,
      plannedDate.day - 1,
      16,
      0,
    );
    return now.isAfter(showAfter);
  }
}
