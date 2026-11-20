import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gelismis_asansor_projesi/src/data/models/fault_model.dart';
import 'package:gelismis_asansor_projesi/src/presentation/faults/providers/fault_provider.dart';
import 'package:gelismis_asansor_projesi/src/core/ads/ad_manager.dart';

class FaultFormScreen extends ConsumerStatefulWidget {
  final String elevatorId;
  final String customerId;

  const FaultFormScreen({super.key, required this.elevatorId, required this.customerId});

  @override
  ConsumerState<FaultFormScreen> createState() => _FaultFormScreenState();
}

class _FaultFormScreenState extends ConsumerState<FaultFormScreen> {
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitFault() async {
    if (descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen arıza tanımını girin')));
      return;
    }

    final cId = int.parse(widget.customerId);
    final eId = int.parse(widget.elevatorId);
    
    final fault = FaultModel(
      serverId: 'local_${DateTime.now().millisecondsSinceEpoch}',
      reportedDate: DateTime.now(),
      description: descriptionController.text.trim(),
      status: FaultStatus.active,
    );

    await ref.read(faultRepositoryProvider).createFault(fault, cId, eId);

    if (mounted) {
      ref.read(adManagerProvider).showInterstitialAd(
        onAdDismissed: () {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Arıza başarıyla bildirildi ve ana ekrana düştü!')));
            context.pop();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Arıza Kaydı', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red.shade800,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                   Icon(Icons.warning_amber_rounded, color: Colors.red.shade800, size: 36),
                   const SizedBox(width: 16),
                   Expanded(
                     child: Text(
                       'Açtığınız bu arıza kaydı otomatik olarak çözülene kadar tüm teknisyenlerin "Aktif Arızalar" panelinde yer alacaktır.',
                       style: TextStyle(color: Colors.red.shade900),
                     ),
                   ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Arıza Tanımı',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Müşteri şikayetini veya tespit ettiğiniz fiziksel arızayı detaylıca açıklayın...',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red.shade800, width: 2)),
              ),
            ),
            const SizedBox(height: 48),
            FilledButton.icon(
              onPressed: _submitFault,
              icon: const Icon(Icons.send),
              label: const Text('ARIZAYI BİLDİR / AKTİFLEŞTİR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red.shade800,
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
