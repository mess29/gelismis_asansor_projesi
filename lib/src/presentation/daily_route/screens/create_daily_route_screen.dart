import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:gelismis_asansor_projesi/src/data/models/daily_route_model.dart';
import 'package:gelismis_asansor_projesi/src/presentation/maintenance/maintenance_group_list_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/daily_route/providers/daily_route_provider.dart';
import 'package:gelismis_asansor_projesi/src/presentation/widgets/app_logo_title.dart';

class CreateDailyRouteScreen extends ConsumerStatefulWidget {
  const CreateDailyRouteScreen({super.key});

  @override
  ConsumerState<CreateDailyRouteScreen> createState() => _CreateDailyRouteScreenState();
}

class _CreateDailyRouteScreenState extends ConsumerState<CreateDailyRouteScreen> {
  DateTime selectedDate = DateTime.now();
  Set<int> selectedGroupIds = {};

  @override
  Widget build(BuildContext context) {
    final groupsAsync = ref.watch(maintenanceGroupsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const AppLogoTitle(title: Text('Günlük Rota Oluştur')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDateSelector(context),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Bakım Yapılacak Bölgeleri Seçin',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: groupsAsync.when(
              data: (groups) {
                if (groups.isEmpty) {
                  return const Center(
                    child: Text('Henüz planlanacak bir bölge yok.\nÖnce Müşteriler sayfasından bölge oluşturun.'),
                  );
                }

                return ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    final isSelected = selectedGroupIds.contains(group.id);

                    return CheckboxListTile(
                      value: isSelected,
                      title: Text(group.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${group.customers.length} Bina'),
                      secondary: Icon(
                        Icons.folder,
                        color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                      ),
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            selectedGroupIds.add(group.id!);
                          } else {
                            selectedGroupIds.remove(group.id!);
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
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 1)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) {
          setState(() {
            selectedDate = date;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.calendar_month, size: 28, color: Colors.blue),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Planlama Tarihi',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey.shade700),
                ),
                Text(
                  DateFormat('dd MMMM yyyy', 'tr_TR').format(selectedDate),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.edit, size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilledButton.icon(
          onPressed: selectedGroupIds.isEmpty ? null : _saveRoute,
          icon: const Icon(Icons.check),
          label: Text('Rotayı Kaydet (${selectedGroupIds.length} Bölge)'),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  Future<void> _saveRoute() async {
    final groupsAsync = ref.read(maintenanceGroupsProvider);
    final allGroups = groupsAsync.valueOrNull ?? [];
    
    final selectedGroupsList = allGroups.where((g) => selectedGroupIds.contains(g.id)).toList();

    final route = DailyRouteModel(
      serverId: 'local_${DateTime.now().millisecondsSinceEpoch}',
      plannedDate: selectedDate,
      status: DailyRouteStatus.pending,
    );
    route.maintenanceGroups.addAll(selectedGroupsList);

    await ref.read(dailyRouteRepositoryProvider).createDailyRoute(route);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Günlük rota başarıyla oluşturuldu!')));
      context.pop();
    }
  }
}
