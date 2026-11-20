import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';
import 'package:gelismis_asansor_projesi/src/data/models/elevator_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/customer_model.dart';
import 'package:gelismis_asansor_projesi/src/presentation/maintenance/providers/maintenance_provider.dart';
import 'package:gelismis_asansor_projesi/src/presentation/widgets/app_logo_title.dart';

class CustomerDetailScreen extends ConsumerWidget {
  final String customerId;

  const CustomerDetailScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // customerId is from path string, but model uses int Id. Convert it.
    final id = int.tryParse(customerId);
    if (id == null) return const Scaffold(body: Center(child: Text('Geçersiz ID')));

    final customerAsync = ref.watch(customerDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: AppLogoTitle(title: Text(customerAsync.valueOrNull?.name ?? 'Bina Detayı')),
        actions: customerAsync.valueOrNull != null
            ? [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.goNamed('add_customer', extra: customerAsync.value!);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Sil?'),
                        content: const Text(
                            'Bu binayı ve bağlı tüm kayıtları silmek istediğinize emin misiniz?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('İptal'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: FilledButton.styleFrom(backgroundColor: Colors.red),
                            child: const Text('Sil'),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true && context.mounted) {
                      await ref
                          .read(customerRepositoryProvider)
                          .deleteCustomer(customerAsync.value!.id!);
                      if (context.mounted) {
                        context.pop(); // Detaydan çık
                        // Listeyi yenilemesi için gerekirse invalidate
                        // (Stream olmadığı için listedeyken build tekrar tetiklenmeyebilir, 
                        // ama yeni sayfaya girmeden invalidate etmek iyidir)
                         ref.invalidate(customerListProvider);
                      }
                    }
                  },
                ),
              ]
            : null,
      ),
      body: customerAsync.when(
        data: (customer) {
          if (customer == null) return const Center(child: Text('Bulunamadı.'));
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoCard(context, customer),
                const SizedBox(height: 24),
                if (customer.transactionHistory.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Son İşlemler',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {
                           context.pushNamed('customer_ledger', pathParameters: {'customerId': customer.id.toString()});
                        },
                        child: const Text('Tümünü Gör'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildTransactionHistoryList(customer, context),
                  const SizedBox(height: 24),
                ],
                Text(
                  'Asansörler',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                _buildElevatorsList(customer, context),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Hata: $err')),
      ),
      floatingActionButton: customerAsync.valueOrNull != null 
        ? FloatingActionButton.extended(
            onPressed: () {
               context.goNamed(
                'add_elevator',
                pathParameters: {'customerId': customerAsync.value!.id.toString()},
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Asansör Ekle'),
          )
        : null,
    );
  }

  Widget _buildInfoCard(BuildContext context, CustomerModel customer) {
    final currencyFormat = '\u20BA'; // TL Sembolü

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(customer.name, style: Theme.of(context).textTheme.headlineSmall),
              subtitle: Text(customer.address),
              leading: const Icon(Icons.business, size: 40),
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.person),
              title: Text(customer.authorizedPerson ?? 'Yetkili Yok'),
              subtitle: const Text('Yetkili Kişi'),
              trailing: IconButton(
                icon: const Icon(Icons.phone),
                onPressed: () {
                  // TODO: Call intent
                },
              ),
            ),
            // Finansal Bilgiler
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context.pushNamed('customer_ledger', pathParameters: {'customerId': customer.id.toString()});
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _infoItem(
                        context, 
                        'Bakiye (Tıkla)', 
                        '${customer.balance.toStringAsFixed(2)} $currencyFormat', 
                        color: customer.balance > 0 ? Colors.red : Colors.green
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _infoItem(
                    context, 
                    'Aylık Ücret', 
                    '${customer.monthlyMaintenanceFee?.toStringAsFixed(2) ?? "0.00"} $currencyFormat'
                  ),
                ),
              ],
            ),
            if (customer.notes != null && customer.notes!.isNotEmpty) ...[
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.note),
                title: const Text('Notlar'),
                subtitle: Text(customer.notes!),
              ),
            ],
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.map),
              title: const Text('Haritada Göster'),
              onTap: () {
                // TODO: Open maps
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionHistoryList(CustomerModel customer, BuildContext context) {
    // Son eklenenler en üstte görünsün
    final history = customer.transactionHistory.reversed.take(5).toList();
    final currencyFormat = '\u20BA';

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: history.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final record = history[index];
          final isPayment = record.type == TransactionType.payment;
          
          return ListTile(
            leading: Icon(
              isPayment ? Icons.payments : Icons.receipt_long, 
              color: isPayment ? Colors.green : Colors.red
            ),
            title: Text(record.description ?? 'İşlem'),
            subtitle: Text(
              record.date != null 
                  ? '${record.date!.day.toString().padLeft(2, '0')}.${record.date!.month.toString().padLeft(2, '0')}.${record.date!.year}'
                  : '',
            ),
            trailing: Text(
              '${isPayment ? "-" : "+"}${record.amount?.toStringAsFixed(2) ?? "0.00"} $currencyFormat',
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: isPayment ? Colors.green : Colors.red
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _infoItem(BuildContext context, String label, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text(
          value, 
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color
          )
        ),
      ],
    );
  }

  Widget _buildElevatorsList(CustomerModel customer, BuildContext context) {
    final elevators = customer.elevators.toList(); 

    if (elevators.isEmpty) {
      return const Text('Kayıtlı asansör yok.');
    }

    return Column(
      children: elevators.map((elevator) {
        return _ElevatorListTile(customer: customer, elevator: elevator);
      }).toList(),
    );
  }
}

class _ElevatorListTile extends ConsumerWidget {
  final CustomerModel customer;
  final ElevatorModel elevator;

  const _ElevatorListTile({required this.customer, required this.elevator});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maintenanceHistoryAsync = ref.watch(maintenanceHistoryForElevatorProvider(elevator.id!));

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.elevator, color: Theme.of(context).primaryColor),
        ),
        title: Text(
          '${elevator.code} ${elevator.name != null && elevator.name!.isNotEmpty ? "- ${elevator.name}" : ""}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${_getElevatorTypeName(elevator.type)} • ${elevator.stops ?? "?"} Durak'),
            const SizedBox(height: 4),
            maintenanceHistoryAsync.when(
              data: (history) {
                if (history.isEmpty) {
                  return const Text('Bakım kaydı yok', style: TextStyle(fontSize: 12, color: Colors.orange));
                }
                final last = history.first;
                final dateStr = '${last.maintenanceDate.day.toString().padLeft(2, '0')}.${last.maintenanceDate.month.toString().padLeft(2, '0')}.${last.maintenanceDate.year}';
                return Text('Son Bakım: $dateStr', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.green));
              },
              loading: () => const SizedBox(height: 12, width: 12, child: CircularProgressIndicator(strokeWidth: 2)),
              error: (err, stack) => const Text('Geçmiş yüklenemedi', style: TextStyle(fontSize: 12, color: Colors.red)),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          context.goNamed(
            'elevator_detail',
            pathParameters: {
              'customerId': customer.id.toString(),
              'elevatorId': elevator.id.toString(),
            },
          );
        },
      ),
    );
  }

  String _getElevatorTypeName(ElevatorType type) {
    switch (type) {
      case ElevatorType.human: return 'İnsan Asansörü';
      case ElevatorType.freight: return 'Yük Asansörü';
      case ElevatorType.stretcher: return 'Sedye Asansörü';
      case ElevatorType.moncharge: return 'Monşarj';
      case ElevatorType.vehicle: return 'Araç Asansörü';
      case ElevatorType.service: return 'Servis Asansörü';
      case ElevatorType.disabled: return 'Engelli Asansörü';
      case ElevatorType.platform: return 'Platform';
      case ElevatorType.other: return 'Diğer';
    }
  }
}
