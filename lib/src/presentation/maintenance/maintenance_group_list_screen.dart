import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gelismis_asansor_projesi/src/data/models/maintenance_group_model.dart';
import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';

final maintenanceGroupSortProvider = StateProvider<MaintenanceGroupSort>((ref) => MaintenanceGroupSort.nameAsc);

final maintenanceGroupsProvider = FutureProvider.autoDispose<List<MaintenanceGroupModel>>((ref) async {
  final repository = ref.watch(customerRepositoryProvider);
  final sort = ref.watch(maintenanceGroupSortProvider);
  return repository.getMaintenanceGroups(sort: sort);
});

class MaintenanceGroupListScreen extends ConsumerWidget {
  const MaintenanceGroupListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(maintenanceGroupsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bakım Bölgeleri / Listeler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_by_alpha),
            onPressed: () => _showSortOptions(context, ref),
            tooltip: 'Sıralama',
          ),
        ],
      ),
      body: groupsAsync.when(
        data: (groups) {
          if (groups.isEmpty) {
            return const Center(child: Text('Henüz bölge/grup oluşturulmadı.'));
          }
          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return ListTile(
                leading: const Icon(Icons.folder_shared),
                title: Text(group.name),
                subtitle: Text('${group.customers.length} Bina'), 
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.pushNamed('maintenance_group_detail', pathParameters: {'groupId': group.id.toString()});
                },
                onLongPress: () => _showDeleteDialog(context, ref, group),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Hata: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSortOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final currentSort = ref.read(maintenanceGroupSortProvider);
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(title: Text('Sıralama', style: TextStyle(fontWeight: FontWeight.bold))),
              const Divider(),
              ListTile(
                title: const Text('İsim (A-Z)'),
                trailing: currentSort == MaintenanceGroupSort.nameAsc ? const Icon(Icons.check) : null,
                onTap: () {
                  ref.read(maintenanceGroupSortProvider.notifier).state = MaintenanceGroupSort.nameAsc;
                  Navigator.pop(context);
                },
              ),
              ListTile(
                 title: const Text('İsim (Z-A)'),
                 trailing: currentSort == MaintenanceGroupSort.nameDesc ? const Icon(Icons.check) : null,
                 onTap: () {
                   ref.read(maintenanceGroupSortProvider.notifier).state = MaintenanceGroupSort.nameDesc;
                   Navigator.pop(context);
                 },
              ),
            ],
          ),
        );
      }
    );
  }

  void _showCreateDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yeni Bölge / Grup Oluştur'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Grup Adı', hintText: 'Örn: Bölge 1'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('İptal')),
          FilledButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await ref.read(customerRepositoryProvider).createMaintenanceGroup(controller.text);
                 ref.invalidate(maintenanceGroupsProvider);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Oluştur'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, MaintenanceGroupModel group) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Grubu Sil'),
        content: Text('${group.name} grubunu silmek istediğinize emin misiniz? Binalar silinmez, sadece gruptan çıkarılır.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('İptal')),
          TextButton(
            onPressed: () async {
              await ref.read(customerRepositoryProvider).deleteMaintenanceGroup(group.id!);
              ref.invalidate(maintenanceGroupsProvider);
              ref.invalidate(customerListProvider); // Ana listeden etiketler silinmeli
              if (context.mounted) Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}
