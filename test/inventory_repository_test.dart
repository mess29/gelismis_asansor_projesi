import 'package:flutter_test/flutter_test.dart';
import 'package:gelismis_asansor_projesi/src/data/models/inventory_model.dart';

void main() {
  group('Inventory Item Model Tests', () {
    test('isLowStock correctly flags quantity at or below threshold', () {
      final item = InventoryItemModel(
        serverId: '1',
        partCode: 'P101',
        name: 'Kapı Pateni',
        category: 'Kapı',
        quantityInVan: 1,
        minQuantityThreshold: 2,
      );

      expect(item.isLowStock, isTrue);
    });

    test('isLowStock returns false when stock is sufficient', () {
      final item = InventoryItemModel(
        serverId: '2',
        partCode: 'P102',
        name: 'Fotosel Sensör',
        category: 'Güvenlik',
        quantityInVan: 5,
        minQuantityThreshold: 2,
      );

      expect(item.isLowStock, isFalse);
    });
  });
}
