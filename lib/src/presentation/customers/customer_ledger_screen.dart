import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/data/models/customer_model.dart';
import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';

class CustomerLedgerScreen extends ConsumerStatefulWidget {
  final String customerId;

  const CustomerLedgerScreen({super.key, required this.customerId});

  @override
  ConsumerState<CustomerLedgerScreen> createState() => _CustomerLedgerScreenState();
}

class _CustomerLedgerScreenState extends ConsumerState<CustomerLedgerScreen> {
  Future<void> _showAddPaymentDialog(BuildContext context, int cId) async {
    final amountController = TextEditingController();
    final descController = TextEditingController();
    
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Tahsilat Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Tutar (TL)', prefixText: '₺ '),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Açıklama (Opsiyonel)', hintText: 'Örn: Elden nakit alındı'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('İptal'),
            ),
            FilledButton(
              onPressed: () async {
                final amount = double.tryParse(amountController.text.replaceAll(',', '.'));
                if (amount != null && amount > 0) {
                  final desc = descController.text.isNotEmpty ? descController.text : 'Tahsilat';
                  await ref.read(customerRepositoryProvider).addPayment(cId, amount, desc);
                  if (ctx.mounted) {
                    Navigator.pop(ctx);
                  }
                }
              },
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );
    
    // Refresh
    ref.invalidate(customerDetailProvider(cId));
  }

  Future<void> _showEditTransactionDialog(BuildContext context, int cId, TransactionRecord record) async {
    final amountController = TextEditingController(text: record.amount?.toString());
    final descController = TextEditingController(text: record.description);
    
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(record.type == TransactionType.payment ? 'Tahsilatı Düzenle' : 'Borcu Düzenle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Tutar (TL)', prefixText: '₺ '),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Açıklama'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('İptal'),
            ),
            FilledButton(
              onPressed: () async {
                final amount = double.tryParse(amountController.text.replaceAll(',', '.'));
                if (amount != null && amount > 0 && record.id != null) {
                  await ref.read(customerRepositoryProvider).updateTransaction(cId, record.id!, amount, descController.text);
                  if (ctx.mounted) {
                    Navigator.pop(ctx);
                  }
                }
              },
              child: const Text('Güncelle'),
            ),
          ],
        );
      },
    );
    
    // Refresh
    ref.invalidate(customerDetailProvider(cId));
  }

  Future<void> _deleteTransaction(int cId, String transactionId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('İşlemi Sil?'),
        content: const Text('Bu işlemi silmek istediğinize emin misiniz? Bakiye bu değişikliğe göre otomatik güncellenecektir.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('İptal')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true), 
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sil')
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(customerRepositoryProvider).deleteTransaction(cId, transactionId);
      ref.invalidate(customerDetailProvider(cId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = int.tryParse(widget.customerId);
    if (id == null) return const Scaffold(body: Center(child: Text('Geçersiz Bina ID')));

    final customerAsync = ref.watch(customerDetailProvider(id));
    final currencyFormat = '\u20BA';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Hesap / İşlemler'),
      ),
      body: customerAsync.when(
        data: (customer) {
          if (customer == null) return const Center(child: Text('Bina bulunamadı.'));

          final history = customer.transactionHistory.reversed.toList();

          return Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text('Mevcut Bakiye', style: TextStyle(color: Colors.white70, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      '${customer.balance.toStringAsFixed(2)} $currencyFormat',
                      style: TextStyle(
                        color: customer.balance > 0 ? Colors.red.shade100 : Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (customer.balance > 0)
                      const Text('Müşteri Borçlu', style: TextStyle(color: Colors.white54)),
                  ],
                ),
              ),
              Expanded(
                child: history.isEmpty 
                  ? const Center(child: Text('Henüz hiçbir işlem bulunmuyor.'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: history.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final record = history[index];
                        final isPayment = record.type == TransactionType.payment;
                        
                        return ListTile(
                          leading: Icon(
                            isPayment ? Icons.payments : Icons.receipt_long, 
                            color: isPayment ? Colors.green : Colors.red,
                            size: 32,
                          ),
                          title: Text(record.description ?? 'İşlem', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            record.date != null 
                                ? '${record.date!.day.toString().padLeft(2, '0')}.${record.date!.month.toString().padLeft(2, '0')}.${record.date!.year}'
                                : '',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${isPayment ? "-" : "+"}${record.amount?.toStringAsFixed(2) ?? "0.00"} $currencyFormat',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 16,
                                  color: isPayment ? Colors.green : Colors.red
                                ),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (val) {
                                  if (val == 'edit') {
                                    _showEditTransactionDialog(context, id, record);
                                  } else if (val == 'delete' && record.id != null) {
                                    _deleteTransaction(id, record.id!);
                                  }
                                },
                                itemBuilder: (ctx) => [
                                  const PopupMenuItem(value: 'edit', child: ListTile(leading: Icon(Icons.edit), title: Text('Düzenle'), contentPadding: EdgeInsets.zero)),
                                  const PopupMenuItem(value: 'delete', child: ListTile(leading: Icon(Icons.delete, color: Colors.red), title: Text('Sil', style: TextStyle(color: Colors.red)), contentPadding: EdgeInsets.zero)),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Hata: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPaymentDialog(context, id),
        icon: const Icon(Icons.add),
        label: const Text('Tahsilat Ekle'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }
}
