import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/core/database/app_database.dart';
import 'package:gelismis_asansor_projesi/src/core/database/database_provider.dart';
import 'package:gelismis_asansor_projesi/src/core/sync/sync_manager.dart';
import 'package:gelismis_asansor_projesi/src/data/models/inventory_model.dart';
import 'package:gelismis_asansor_projesi/src/domain/repositories/inventory_repository.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final syncManager = ref.watch(syncManagerProvider);
  return InventoryRepositoryImpl(db, syncManager);
});

class InventoryRepositoryImpl implements InventoryRepository {
  final AppDatabase db;
  final SyncManager syncManager;

  InventoryRepositoryImpl(this.db, this.syncManager);

  @override
  Future<List<InventoryItemModel>> getVanStock() async {
    final rows = await db.select(db.inventoryItems).get();
    if (rows.isEmpty) {
      // Seed default common elevator parts if database is fresh
      await _seedDefaultInventory();
      final freshRows = await db.select(db.inventoryItems).get();
      return freshRows.map(_mapItem).toList();
    }
    return rows.map(_mapItem).toList();
  }

  InventoryItemModel _mapItem(InventoryItem row) {
    return InventoryItemModel(
      id: row.id,
      serverId: row.serverId,
      partCode: row.partCode,
      name: row.name,
      category: row.category,
      quantityInVan: row.quantityInVan,
      minQuantityThreshold: row.minQuantityThreshold,
      unitPrice: row.unitPrice,
      unit: row.unit,
    );
  }

  Future<void> _seedDefaultInventory() async {
    final defaults = [
      InventoryItemModel(serverId: 'inv_1', partCode: 'PRT-101', name: 'Kapı Pateni / Kaşığı', category: 'Kapı', quantityInVan: 12, minQuantityThreshold: 4, unitPrice: 150.0),
      InventoryItemModel(serverId: 'inv_2', partCode: 'PRT-102', name: 'Fotosel Sensör Takımı', category: 'Güvenlik', quantityInVan: 3, minQuantityThreshold: 2, unitPrice: 1200.0),
      InventoryItemModel(serverId: 'inv_3', partCode: 'PRT-103', name: 'Kabin Buton Modülü', category: 'Kumanda', quantityInVan: 8, minQuantityThreshold: 3, unitPrice: 350.0),
      InventoryItemModel(serverId: 'inv_4', partCode: 'PRT-104', name: 'Revizyon Anahtarı', category: 'Elektrik', quantityInVan: 5, minQuantityThreshold: 2, unitPrice: 220.0),
      InventoryItemModel(serverId: 'inv_5', partCode: 'PRT-105', name: 'Kuyu Sınır Şalteri', category: 'Güvenlik', quantityInVan: 6, minQuantityThreshold: 2, unitPrice: 450.0),
      InventoryItemModel(serverId: 'inv_6', partCode: 'PRT-106', name: 'Halat Yağı (5L)', category: 'Bakım', quantityInVan: 2, minQuantityThreshold: 1, unitPrice: 600.0),
    ];

    for (final item in defaults) {
      await db.into(db.inventoryItems).insert(
        InventoryItemsCompanion.insert(
          serverId: item.serverId,
          partCode: item.partCode,
          name: item.name,
          category: item.category,
          quantityInVan: Value(item.quantityInVan),
          minQuantityThreshold: Value(item.minQuantityThreshold),
          unitPrice: Value(item.unitPrice),
          unit: Value(item.unit),
        ),
      );
    }
  }

  @override
  Future<void> addOrUpdateInventoryItem(InventoryItemModel item) async {
    await db.into(db.inventoryItems).insertOnConflictUpdate(
      InventoryItemsCompanion(
        id: item.id != null ? Value(item.id!) : const Value.absent(),
        serverId: Value(item.serverId),
        partCode: Value(item.partCode),
        name: Value(item.name),
        category: Value(item.category),
        quantityInVan: Value(item.quantityInVan),
        minQuantityThreshold: Value(item.minQuantityThreshold),
        unitPrice: Value(item.unitPrice),
        unit: Value(item.unit),
      ),
    );
  }

  @override
  Future<void> consumeStock(String partCode, int quantity) async {
    final query = db.select(db.inventoryItems)..where((t) => t.partCode.equals(partCode));
    final item = await query.getSingleOrNull();

    if (item != null) {
      final newQty = (item.quantityInVan - quantity).clamp(0, 9999);
      await (db.update(db.inventoryItems)..where((t) => t.id.equals(item.id)))
          .write(InventoryItemsCompanion(quantityInVan: Value(newQty)));
    }
  }

  @override
  Future<List<PartRequestModel>> getPartRequests() async {
    final rows = await (db.select(db.partRequests)
      ..orderBy([(t) => OrderingTerm(expression: t.requestedAt, mode: OrderingMode.desc)]))
      .get();

    return rows.map((r) => PartRequestModel(
      id: r.id,
      serverId: r.serverId,
      elevatorId: r.elevatorId,
      customerId: r.customerId,
      partName: r.partName,
      quantity: r.quantity,
      urgency: r.urgency,
      status: r.status,
      requestedAt: r.requestedAt,
      notes: r.notes,
      isSynced: r.isSynced,
    )).toList();
  }

  @override
  Future<void> requestPart(PartRequestModel request) async {
    await db.into(db.partRequests).insert(
      PartRequestsCompanion.insert(
        serverId: request.serverId,
        elevatorId: Value(request.elevatorId),
        customerId: Value(request.customerId),
        partName: request.partName,
        quantity: Value(request.quantity),
        urgency: Value(request.urgency),
        status: Value(request.status),
        requestedAt: request.requestedAt,
        notes: Value(request.notes),
        isSynced: Value(request.isSynced),
      ),
    );

    // Queue for sync
    await syncManager.addToQueue('REQUEST_PART', {
      'serverId': request.serverId,
      'partName': request.partName,
      'quantity': request.quantity,
      'urgency': request.urgency,
      'requestedAt': request.requestedAt.toIso8601String(),
    });
  }

  @override
  Future<void> updatePartRequestStatus(int id, String newStatus) async {
    await (db.update(db.partRequests)..where((t) => t.id.equals(id)))
        .write(PartRequestsCompanion(status: Value(newStatus)));
  }
}
