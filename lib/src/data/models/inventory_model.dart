class InventoryItemModel {
  int? id;
  String serverId;
  String partCode;
  String name;
  String category;
  int quantityInVan;
  int minQuantityThreshold;
  double unitPrice;
  String unit;

  InventoryItemModel({
    this.id,
    required this.serverId,
    required this.partCode,
    required this.name,
    required this.category,
    this.quantityInVan = 0,
    this.minQuantityThreshold = 1,
    this.unitPrice = 0.0,
    this.unit = 'Adet',
  });

  bool get isLowStock => quantityInVan <= minQuantityThreshold;
}

class PartRequestModel {
  int? id;
  String serverId;
  int? elevatorId;
  int? customerId;
  String partName;
  int quantity;
  String urgency; // Low, Medium, High, Emergency
  String status; // Pending, Approved, Dispatched, Delivered, Cancelled
  DateTime requestedAt;
  String? notes;
  bool isSynced;

  PartRequestModel({
    this.id,
    required this.serverId,
    this.elevatorId,
    this.customerId,
    required this.partName,
    this.quantity = 1,
    this.urgency = 'Medium',
    this.status = 'Pending',
    required this.requestedAt,
    this.notes,
    this.isSynced = false,
  });
}
