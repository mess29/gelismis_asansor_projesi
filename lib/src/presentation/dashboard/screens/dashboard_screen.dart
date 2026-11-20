import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gelismis_asansor_projesi/src/presentation/auth/providers/profile_provider.dart';
import 'package:gelismis_asansor_projesi/src/presentation/dashboard/providers/dashboard_provider.dart';
import 'package:gelismis_asansor_projesi/src/presentation/daily_route/providers/daily_route_provider.dart';
import 'package:gelismis_asansor_projesi/src/data/models/daily_route_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/fault_model.dart';
import 'package:gelismis_asansor_projesi/src/presentation/widgets/app_logo_title.dart';
import 'package:gelismis_asansor_projesi/src/presentation/widgets/ads/banner_ad_widget.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyRoutesAsync = ref.watch(dailyRoutesProvider);
    final activeFaultsAsync = ref.watch(activeFaultsProvider);
    final profileAsync = ref.watch(profileProvider);

    // Aynı zamanda Android'de geri tuşu ile uygulamadan direkt çıkılmasını engelleyen yapı
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, dynamic result) async {
        if (didPop) return;
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Çıkış'),
            content: const Text('Uygulamadan çıkmak istiyor musunuz?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('İptal'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Çıkış Yap'),
              ),
            ],
          ),
        );
        if (shouldPop == true) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppLogoTitle(title: Text('Ana Ekran')),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_task),
              tooltip: 'Yeni Rota Oluştur',
              onPressed: () => context.pushNamed('create_daily_route'),
            ),
          ],
        ),
        body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            profileAsync.when(
              data: (profile) {
                final hasName = profile != null && profile.fullName.isNotEmpty;
                final hasCompany = profile != null && profile.companyName.isNotEmpty;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      hasName ? 'Hoş Geldin, ${profile.fullName}!' : 'Hoş Geldin!',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (hasCompany) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.business_center, size: 20, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            profile.companyName,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                );
              },
              loading: () => const SizedBox(),
              error: (err, stack) => Text(
                'Hoş Geldin!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            dailyRoutesAsync.when(
              data: (routes) => _buildDailyRoutesSection(context, ref, routes),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => const SizedBox(),
            ),
            const SizedBox(height: 24),
            
            // Aktif Arızalar
            activeFaultsAsync.when(
              data: (faults) => _buildActiveFaultsSection(context, faults),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => const SizedBox(),
            ),
            // Saha Teknisyeni Hızlı Hızlı Eylemler (Van Stock & Teşhis Kılavuzu)
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.build_circle, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Saha Araçları & Hızlı Erişim',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => context.push('/customers/van-stock'),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)),
                              ),
                              child: Column(
                                children: const [
                                  Icon(Icons.airport_shuttle, size: 32, color: Color(0xFF0D47A1)),
                                  SizedBox(height: 6),
                                  Text(
                                    'Araç Stoğu & Parça',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () => context.push('/customers/troubleshooting'),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3)),
                              ),
                              child: Column(
                                children: const [
                                  Icon(Icons.quick_contacts_dialer, size: 32, color: Color(0xFF1976D2)),
                                  SizedBox(height: 6),
                                  Text(
                                    'Hata Kütüphanesi',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const SafeArea(
        child: BannerAdWidget(),
      ),
    ));
  }
  Widget _buildDailyRoutesSection(BuildContext context, WidgetRef ref, List<DailyRouteModel> routes) {
    if (routes.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Bugün için planlanmış bir bakım rotası bulunmuyor.'),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Bugünün / Yaklaşan Rotası',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...routes.map((route) {
          final isToday = route.plannedDate.day == DateTime.now().day;
          return Card(
            child: ListTile(
              leading: Icon(Icons.route, color: Theme.of(context).colorScheme.primary),
              title: Text(
                isToday ? 'Bugünün Rotası' : '${DateFormat('dd.MM.yyyy').format(route.plannedDate)} Rotası',
                style: TextStyle(
                  decoration: route.status == DailyRouteStatus.completed ? TextDecoration.lineThrough : null,
                  color: route.status == DailyRouteStatus.completed ? Colors.grey : null,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('${route.maintenanceGroups.length} Bölge seçildi'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Rotayı Sil'),
                          content: const Text('Bu rotayı silmek istediğinize emin misiniz?\nUyarı: Bu işlem sadece planı siler, yapılan bakımları silmez.'),
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
                      if (confirm == true && context.mounted) {
                        // ignore: unused_result
                        ref.read(dailyRouteRepositoryProvider).deleteDailyRoute(route.id!);
                      }
                    },
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              onTap: () {
                context.pushNamed('daily_route_detail', pathParameters: {'routeId': route.id.toString()});
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildActiveFaultsSection(BuildContext context, List<FaultModel> faults) {
    if (faults.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Aktif Arızalar',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.red.shade800),
        ),
        const SizedBox(height: 8),
        ...faults.map((fault) {
          return Card(
            color: Colors.red.shade50,
            child: ListTile(
              leading: Icon(Icons.warning, color: Colors.red.shade800),
              title: Text(
                '${fault.customer?.name ?? "Bilinmiyor"} / ${fault.elevator?.name ?? "Bilinmiyor"}',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade900),
              ),
              subtitle: Text(DateFormat('dd.MM.yyyy HH:mm').format(fault.reportedDate)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                context.pushNamed('fault_resolution', pathParameters: {'faultId': fault.id.toString()});
              },
            ),
          );
        }),
      ],
    );
  }
}