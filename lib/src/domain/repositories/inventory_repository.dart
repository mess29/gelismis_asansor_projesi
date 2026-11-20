import 'package:gelismis_asansor_projesi/src/data/models/inventory_model.dart';

abstract class InventoryRepository {
  Future<List<InventoryItemModel>> getVanStock();
  Future<void> addOrUpdateInventoryItem(InventoryItemModel item);
  Future<void> consumeStock(String partCode, int quantity);
  Future<List<PartRequestModel>> getPartRequests();
  Future<void> requestPart(PartRequestModel request);
  Future<void> updatePartRequestStatus(int id, String newStatus);
}
