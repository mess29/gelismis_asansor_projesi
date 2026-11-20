import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/data/models/inventory_model.dart';
import 'package:gelismis_asansor_projesi/src/data/repositories/inventory_repository_impl.dart';

final vanStockListProvider = FutureProvider.autoDispose<List<InventoryItemModel>>((ref) async {
  final repo = ref.watch(inventoryRepositoryProvider);
  return repo.getVanStock();
});

final partRequestsListProvider = FutureProvider.autoDispose<List<PartRequestModel>>((ref) async {
  final repo = ref.watch(inventoryRepositoryProvider);
  return repo.getPartRequests();
});

class VanStockScreen extends ConsumerStatefulWidget {
  const VanStockScreen({super.key});

  @override
  ConsumerState<VanStockScreen> createState() => _VanStockScreenState();
}

class _VanStockScreenState extends ConsumerState<VanStockScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showPartRequestDialog(BuildContext context) {
    final partNameController = TextEditingController();
    final qtyController = TextEditingController(text: '1');
    final notesController = TextEditingController();
    String urgency = 'Medium';

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Depodan Parça Talebi'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: partNameController,
                      decoration: const InputDecoration(labelText: 'Parça Adı / Kodu'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: qtyController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Miktar'),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: urgency,
                      decoration: const InputDecoration(labelText: 'Aciliyet Durumu'),
                      items: const [
                        DropdownMenuItem(value: 'Low', child: Text('Düşük')),
                        DropdownMenuItem(value: 'Medium', child: Text('Normal')),
                        DropdownMenuItem(value: 'High', child: Text('Yüksek')),
                        DropdownMenuItem(value: 'Emergency', child: Text('ACİL (Asansör Kalmış)')),
                      ],
                      onChanged: (val) {
                        if (val != null) setDialogState(() => urgency = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: notesController,
                      maxLines: 2,
                      decoration: const InputDecoration(labelText: 'Açıklama / Not'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('İptal'),
                ),
                FilledButton(
                  onPressed: () async {
                    if (partNameController.text.trim().isEmpty) return;
                    final req = PartRequestModel(
                      serverId: 'req_${DateTime.now().millisecondsSinceEpoch}',
                      partName: partNameController.text.trim(),
                      quantity: int.tryParse(qtyController.text) ?? 1,
                      urgency: urgency,
                      requestedAt: DateTime.now(),
                      notes: notesController.text.trim(),
                    );

                    await ref.read(inventoryRepositoryProvider).requestPart(req);
                    ref.invalidate(partRequestsListProvider);
                    if (context.mounted) Navigator.pop(ctx);
                  },
                  child: const Text('Talebi Gönder'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Araç Stoğu & Yedek Parça'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.airport_shuttle), text: 'Araç Stoğum'),
            Tab(icon: Icon(Icons.assignment_returned), text: 'Parça Taleplerim'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showPartRequestDialog(context),
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Parça Talep Et'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildVanStockTab(theme),
          _buildPartRequestsTab(theme),
        ],
      ),
    );
  }

  Widget _buildVanStockTab(ThemeData theme) {
    final stockAsync = ref.watch(vanStockListProvider);

    return stockAsync.when(
      data: (items) {
        if (items.isEmpty) {
          return const Center(child: Text('Araç stoğunda parça bulunmamaktadır.'));
        }

        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(vanStockListProvider),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item.isLowStock
                        ? Colors.red.withValues(alpha: 0.15)
                        : theme.colorScheme.primary.withValues(alpha: 0.15),
                    child: Icon(
                      item.isLowStock ? Icons.warning : Icons.build,
                      color: item.isLowStock ? Colors.red : theme.colorScheme.primary,
                    ),
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text('Kod: ${item.partCode} | Kategori: ${item.category}\nBirim Fiyat: ₺${item.unitPrice.toStringAsFixed(2)}'),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: item.isLowStock ? Colors.red : Colors.green.shade700,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${item.quantityInVan} ${item.unit}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Hata oluştu: $err')),
    );
  }

  Widget _buildPartRequestsTab(ThemeData theme) {
    final requestsAsync = ref.watch(partRequestsListProvider);

    return requestsAsync.when(
      data: (requests) {
        if (requests.isEmpty) {
          return const Center(child: Text('Henüz verilmiş bir parça talebi yok.'));
        }

        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(partRequestsListProvider),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final req = requests[index];
              return Card(
                child: ListTile(
                  title: Text(
                    '${req.partName} (${req.quantity} Adet)',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Aciliyet: ${req.urgency} | Tarih: ${req.requestedAt.day}.${req.requestedAt.month}.${req.requestedAt.year}\nNot: ${req.notes ?? '-'}'),
                  trailing: Chip(
                    label: Text(req.status),
                    backgroundColor: req.status == 'Pending'
                        ? Colors.orange.shade100
                        : Colors.green.shade100,
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Hata oluştu: $err')),
    );
  }
}
