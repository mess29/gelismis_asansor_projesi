import 'customer_model.dart';

class MaintenanceGroupModel {
  int? id;

  String name; // Bölge/Grup Adı (Örn: "Bölge 1", "Müşteri A Listesi")

  // Bu gruba ait müşteriler
  List<CustomerModel> customers = [];

  MaintenanceGroupModel({
    this.id,
    required this.name,
    this.customers = const [],
  });
}
