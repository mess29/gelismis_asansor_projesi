import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:gelismis_asansor_projesi/src/presentation/faults/providers/fault_provider.dart';
import 'package:gelismis_asansor_projesi/src/data/models/maintenance_model.dart';
import 'package:gelismis_asansor_projesi/src/presentation/widgets/app_logo_title.dart';
import 'package:gelismis_asansor_projesi/src/core/ads/ad_manager.dart';

class FaultResolutionScreen extends ConsumerStatefulWidget {
  final int faultId;

  const FaultResolutionScreen({super.key, required this.faultId});

  @override
  ConsumerState<FaultResolutionScreen> createState() => _FaultResolutionScreenState();
}

class _FaultResolutionScreenState extends ConsumerState<FaultResolutionScreen> {
  final TextEditingController noteController = TextEditingController();
  final List<UsedMaterial> _usedMaterials = [];
  bool isSubmitting = false;

  void _addMaterial() {
    setState(() {
      _usedMaterials.add(UsedMaterial(name: '', quantity: 1, price: 0.0));
    });
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  Future<void> _resolveFault() async {
    if (noteController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen çözüm için bir not giriniz.')));
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      final validMaterials = _usedMaterials
          .where((m) => m.name != null && m.name!.trim().isNotEmpty && m.price > 0)
          .toList();

      await ref.read(faultRepositoryProvider).resolveFault(widget.faultId, noteController.text.trim(), validMaterials);
      
      if (mounted) {
        ref.read(adManagerProvider).showInterstitialAd(
          onAdDismissed: () {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Arıza başarıyla kapatıldı!')));
              context.pop();
            }
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hata: $e')));
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final faultAsync = ref.watch(faultDetailProvider(widget.faultId));

    return Scaffold(
      appBar: AppBar(
        title: const AppLogoTitle(title: Text('Arızayı Kapat / Çöz')),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            faultAsync.when(
              data: (fault) {
                if (fault == null) return const SizedBox.shrink();
                return Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${fault.customer?.name ?? "Bilinmiyor"} / ${fault.elevator?.name ?? "Bilinmiyor"}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red.shade900),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Bildirim: ${DateFormat('dd.MM.yyyy HH:mm').format(fault.reportedDate)}',
                        style: TextStyle(color: Colors.red.shade800),
                      ),
                      const Divider(height: 24),
                      const Text('Arıza Açıklaması:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(fault.description, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Text('Hata: $err'),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                   Icon(Icons.check_circle_outline, color: Colors.green.shade700, size: 36),
                   const SizedBox(width: 16),
                   Expanded(
                     child: Text(
                       'Bu arızayı çözüldü olarak işaretlemek üzeresiniz. Girilen not asansör geçmişine kalıcı olarak kaydedilecektir.',
                       style: TextStyle(color: Colors.green.shade900),
                     ),
                   ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Teknisyen Çözüm Notu (Ne yapıldı?)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: noteController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Değişen parçaları veya yapılan müdahaleyi açıklayınız...',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade700, width: 2)),
              ),
            ),
            
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Kullanılan Malzemeler', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                IconButton(
                  onPressed: _addMaterial,
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                  tooltip: 'Malzeme Ekle',
                ),
              ],
            ),
            const Text('Eklenen malzemelerin toplam tutarı otomatik olarak cari hesaba "Borç" olarak yansıtılacaktır.', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
            if (_usedMaterials.isEmpty)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Kullanılan malzeme yok.'),
              )
            else
              Card(
                child: Column(
                  children: List.generate(_usedMaterials.length, (index) {
                    final material = _usedMaterials[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              decoration: InputDecoration(labelText: 'Malzeme Adı ${index + 1}', isDense: true),
                              onChanged: (val) => material.name = val,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: 'Miktar', isDense: true),
                              onChanged: (val) => material.quantity = int.tryParse(val) ?? 1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: const InputDecoration(labelText: 'Tutar (TL)', isDense: true),
                              onChanged: (val) {
                                material.price = double.tryParse(val.replaceAll(',', '.')) ?? 0.0;
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _usedMaterials.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

            const SizedBox(height: 48),
            FilledButton.icon(
              onPressed: isSubmitting ? null : _resolveFault,
              icon: isSubmitting 
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Icon(Icons.done_all),
              label: Text(isSubmitting ? 'KAYDEDİLİYOR...' : 'ARIZAYI TAMAMLA', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
