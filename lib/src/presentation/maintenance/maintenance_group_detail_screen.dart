import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gelismis_asansor_projesi/src/data/models/customer_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/maintenance_group_model.dart';
import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';
import 'package:intl/intl.dart';

final maintenanceGroupDetailProvider = FutureProvider.autoDispose.family<MaintenanceGroupModel?, int>((ref, id) async {
  final repository = ref.watch(customerRepositoryProvider);
  final group = await repository.getMaintenanceGroupById(id);
  if (group != null) {
    // 
  }
  return group;
});

final availableCustomersProvider = FutureProvider.autoDispose<List<CustomerModel>>((ref) async {
  final repository = ref.watch(customerRepositoryProvider);
  return repository.getAvailableCustomers();
});

class MaintenanceGroupDetailScreen extends ConsumerWidget {
  final int groupId;

  const MaintenanceGroupDetailScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupAsync = ref.watch(maintenanceGroupDetailProvider(groupId));

    return Scaffold(
      appBar: AppBar(
        title: groupAsync.when(
          data: (group) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(group?.name ?? 'Bölge Detayı'),
              Text(
                DateFormat('MMMM yyyy', 'tr_TR').format(DateTime.now()), 
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white70),
              ),
            ],
          ),
          loading: () => const Text('Yükleniyor...'),
          error: (e, stack) => const Text('Hata'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.playlist_add_check),
            tooltip: 'Bu Grup İçin Günlük Bakım Oluştur',
            onPressed: () => _showBulkCreateDialog(context, ref),
          ),
        ],
      ),
      body: groupAsync.when(
        data: (group) {
          if (group == null) return const Center(child: Text('Grup bulunamadı.'));

          final customers = group.customers.toList();

          if (customers.isEmpty) {
            return const Center(child: Text('Bu gruba henüz bina eklenmemiş.'));
          }

          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.business, color: Colors.blue),
                ),
                title: Text(customer.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${customer.city} / ${customer.district}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Binayı Çıkar?'),
                              content: const Text('Bu binayı bakım bölgesinden çıkarmak istediğinize emin misiniz?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('İptal')),
                                FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Çıkar')),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            try {
                              await ref.read(customerRepositoryProvider).removeCustomerFromGroup(customer.id!);
                              
                              ref.invalidate(maintenanceGroupDetailProvider(groupId));
                              ref.invalidate(availableCustomersProvider); 
                              
                              if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bina başarıyla çıkarıldı.')));
                              }
                            } catch (e) {
                              if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Çıkarma hatası: $e')));
                              }
                            }
                          }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () => _showContextOptions(context, ref, customer),
                    ),
                  ],
                ),
                onTap: () => _showContextOptions(context, ref, customer),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Hata: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCustomerSheet(context, ref),
        label: const Text('Bina Ekle'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _showContextOptions(BuildContext context, WidgetRef ref, CustomerModel customer) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Bina Detayına Git'),
              onTap: () {
                Navigator.pop(context);
                // GoRouter ile detay sayfasına git
                // context.pushNamed('customer_detail', pathParameters: {'customerId': customer.id.toString()});
                // Ancak "maintenance-groups" içindeyiz, rotalar farklı olabilir.
                // En garantisi absolute path kullanmak veya customer listesinden gitmek.
                // context.go('/customers/detail/${customer.id}'); // Bu pattern app_router'da var mı?
                // /customers/detail/:customerId 
                // Router yapısına göre:
                // /customers/detail/123
                context.push('/customers/detail/${customer.id}');
              },
            ),
            ListTile(
              leading: const Icon(Icons.build),
              title: const Text('Bakım İş Emri Oluştur'),
              onTap: () {
                Navigator.pop(context);
                context.pushNamed('customer_detail', pathParameters: {'customerId': customer.id.toString()});
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCustomerSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _AddCustomerSheet(groupId: groupId),
    );
  }

  void _showBulkCreateDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Toplu Bakım Listesi Oluştur'),
        content: const Text(
          'Bu gruptaki (bölgedeki) tüm asansörler için bugüne ait periyodik bakım iş emirleri oluşturulacak.\n\nEğer bu ay için zaten oluşturulmuş kayıtlar varsa, tekrar oluşturulmaz.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('İptal')),
          FilledButton.icon(
            icon: const Icon(Icons.playlist_add_check),
            label: const Text('Oluştur'),
            onPressed: () async {
              Navigator.pop(context); // Dialog kapat
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Yeni DailyRoute yapısı henüz eklenmedi.')));
              }
            },
          ),
        ],
      ),
    );
  }
}

class _AddCustomerSheet extends ConsumerStatefulWidget {
  final int groupId;
  const _AddCustomerSheet({required this.groupId});

  @override
  ConsumerState<_AddCustomerSheet> createState() => _AddCustomerSheetState();
}

class _AddCustomerSheetState extends ConsumerState<_AddCustomerSheet> {
  final Set<int> _selectedIds = {};

  @override
  Widget build(BuildContext context) {
    final availableCustomersAsync = ref.watch(availableCustomersProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, scrollController) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bina Seç', style: Theme.of(context).textTheme.titleLarge),
                  if (_selectedIds.isNotEmpty)
                    FilledButton(
                      onPressed: () async {
                        try {
                          await ref.read(customerRepositoryProvider).assignCustomersToGroup(widget.groupId, _selectedIds.toList());
                          // UI güncelleme
                          ref.invalidate(maintenanceGroupDetailProvider(widget.groupId));
                          ref.invalidate(availableCustomersProvider); // Listeden düşmeli
                          ref.invalidate(customerListProvider); // Ana listeye etiket gelmeli
                          
                          if (context.mounted) {
                             Navigator.pop(context);
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${_selectedIds.length} bina eklendi.')));
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hata: $e')));
                          }
                        }
                      },
                      child: Text('Ekle (${_selectedIds.length})'),
                    ),
                ],
              ),
            ),
            Expanded(
              child: availableCustomersAsync.when(
                data: (customers) {
                  if (customers.isEmpty) {
                     return const Center(child: Text('Eklenebilecek boşta bina yok.'));
                  }
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      final customer = customers[index];
                      final isSelected = _selectedIds.contains(customer.id);
                      return CheckboxListTile(
                        value: isSelected,
                        title: Text(customer.name),
                        subtitle: Text('${customer.city} / ${customer.district}'),
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              _selectedIds.add(customer.id!);
                            } else {
                              _selectedIds.remove(customer.id!);
                            }
                          });
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Hata: $err')),
              ),
            ),
          ],
        );
      },
    );
  }
}
