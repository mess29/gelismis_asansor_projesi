import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:gelismis_asansor_projesi/src/presentation/daily_route/providers/daily_route_provider.dart';
import 'package:gelismis_asansor_projesi/src/presentation/widgets/app_logo_title.dart';

class DailyRouteDetailScreen extends ConsumerWidget {
  final int routeId;

  const DailyRouteDetailScreen({super.key, required this.routeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeDataAsync = ref.watch(dailyRouteDetailCustomersProvider(routeId));

    return Scaffold(
      appBar: AppBar(
        title: AppLogoTitle(
          title: routeDataAsync.when(
            data: (data) {
              if (data == null) return const Text('Rota Bulunamadı');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Günlük Rota'),
                  Text(
                    DateFormat('dd MMMM yyyy', 'tr_TR').format(data.route.plannedDate),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white70),
                  ),
                ],
              );
            },
            loading: () => const Text('Yükleniyor...'),
            error: (err, stack) => const Text('Hata'),
          ),
        ),
      ),
      body: routeDataAsync.when(
        data: (data) {
          if (data == null) {
            return const Center(child: Text('Aradığınız rota mevcut değil.'));
          }

          final route = data.route;
          final groups = route.maintenanceGroups.toList();
          
          if (groups.isEmpty) {
            return const Center(child: Text('Bu rotaya herhangi bir bölge eklenmemiş.'));
          }

          // Filtrelenmiş müşterileri bir Set'te tutarak hızlıca kontrol edelim
          final pendingIds = data.pendingCustomers.map((c) => c.id).toSet();
          final completedIds = data.completedCustomers.map((c) => c.id).toSet();

          // Gösterilecek müşterisi olmayan grupları filtreleyelim
          final groupsWithCustomers = groups.where((g) {
            return g.customers.any((c) => pendingIds.contains(c.id) || completedIds.contains(c.id));
          }).toList();

          if (groupsWithCustomers.isEmpty) {
             return const Center(child: Text('Bu rotadaki tüm asansörlerin bakımları atanmış/tamamlanmış.'));
          }

          return ListView.builder(
            itemCount: groupsWithCustomers.length,
            itemBuilder: (context, groupIndex) {
              final group = groupsWithCustomers[groupIndex];
              
              // Sadece rotada görünmesi gereken müşteriler
              final customers = group.customers.where((c) {
                 return pendingIds.contains(c.id) || completedIds.contains(c.id);
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.blue.shade50,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Text(
                      group.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                  ...customers.map((customer) {
                    final isCompleted = completedIds.contains(customer.id);

                    return ListTile(
                      leading: isCompleted
                          ? const Icon(Icons.check_circle, color: Colors.green, size: 40)
                          : CircleAvatar(
                              backgroundColor: Colors.blue.shade100,
                              child: Icon(Icons.business, color: Theme.of(context).colorScheme.primary),
                            ),
                      title: Text(
                        customer.name, 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                          color: isCompleted ? Colors.grey : null,
                        ),
                      ),
                      subtitle: Text('${customer.city} / ${customer.district}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                         context.pushNamed('customer_detail', pathParameters: {'customerId': customer.id.toString()});
                      },
                    );
                  }),
                  const Divider(height: 1),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Rota Yüklenirken Hata Oluştu: $err')),
      ),
    );
  }
}
