import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/data/models/error_code_model.dart';
import 'package:gelismis_asansor_projesi/src/data/repositories/error_code_repository_impl.dart';

final selectedBrandProvider = StateProvider<String>((ref) => 'Tümü');
final searchQueryProvider = StateProvider<String>((ref) => '');

final errorCodesProvider = FutureProvider.autoDispose<List<ErrorCodeModel>>((ref) async {
  final repo = ref.watch(errorCodeRepositoryProvider);
  final brand = ref.watch(selectedBrandProvider);
  final query = ref.watch(searchQueryProvider);
  return repo.searchErrorCodes(brand: brand, query: query);
});

final troubleshootingGuidesProvider = FutureProvider.autoDispose<List<TroubleshootingGuideModel>>((ref) async {
  final repo = ref.watch(errorCodeRepositoryProvider);
  final brand = ref.watch(selectedBrandProvider);
  return repo.getTroubleshootingGuides(brand: brand);
});

class TroubleshootingGuideScreen extends ConsumerStatefulWidget {
  const TroubleshootingGuideScreen({super.key});

  @override
  ConsumerState<TroubleshootingGuideScreen> createState() => _TroubleshootingGuideScreenState();
}

class _TroubleshootingGuideScreenState extends ConsumerState<TroubleshootingGuideScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedBrand = ref.watch(selectedBrandProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arıza Kütüphanesi & Teşhis Kılavuzu'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.qr_code_scanner), text: 'Hata Kodları (Offline)'),
            Tab(icon: Icon(Icons.checklist), text: 'Adım Adım Teşhis'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Bar
          Container(
            color: theme.colorScheme.surface,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['Tümü', 'Arkel', 'Mikrolift', 'Aybey', 'Fuji', 'Genel'].map((brand) {
                      final isSelected = selectedBrand == brand;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(brand),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              ref.read(selectedBrandProvider.notifier).state = brand;
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Hata kodu (Er-01) veya belirti ara...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              ref.read(searchQueryProvider.notifier).state = '';
                            },
                          )
                        : null,
                  ),
                  onChanged: (val) {
                    ref.read(searchQueryProvider.notifier).state = val;
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildErrorCodeTab(theme),
                _buildTroubleshootingGuideTab(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCodeTab(ThemeData theme) {
    final errorsAsync = ref.watch(errorCodesProvider);

    return errorsAsync.when(
      data: (errorList) {
        if (errorList.isEmpty) {
          return const Center(child: Text('Aradığınız kriterlere uygun hata kodu bulunamadı.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: errorList.length,
          itemBuilder: (context, index) {
            final error = errorList[index];
            return Card(
              child: ExpansionTile(
                leading: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    error.code,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                title: Text(error.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Marka: ${error.brand}'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Olası Neden (Root Cause):',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        const SizedBox(height: 4),
                        Text(error.rootCause),
                        const SizedBox(height: 12),
                        const Text(
                          'Saha Çözüm Adımları:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        const SizedBox(height: 6),
                        ...error.solutionSteps.asMap().entries.map((entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: theme.colorScheme.primary,
                                child: Text('${entry.key + 1}', style: const TextStyle(fontSize: 10, color: Colors.white)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text(entry.value)),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Hata oluştu: $err')),
    );
  }

  Widget _buildTroubleshootingGuideTab(ThemeData theme) {
    final guidesAsync = ref.watch(troubleshootingGuidesProvider);

    return guidesAsync.when(
      data: (guides) {
        if (guides.isEmpty) {
          return const Center(child: Text('Teşhis kılavuzu bulunamadı.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: guides.length,
          itemBuilder: (context, index) {
            final guide = guides[index];
            return Card(
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.2),
                  child: const Icon(Icons.build_circle),
                ),
                title: Text(guide.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Kategori: ${guide.category} | Marka: ${guide.brand}'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Belirti / Semptom:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                        const SizedBox(height: 4),
                        Text(guide.symptom),
                        const SizedBox(height: 12),
                        const Text(
                          'Adım Adım Kontrol Listesi:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        const SizedBox(height: 6),
                        ...guide.diagnosticSteps.map((step) => CheckboxListTile(
                          dense: true,
                          value: false,
                          onChanged: (val) {},
                          title: Text(step),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Hata oluştu: $err')),
    );
  }
}
