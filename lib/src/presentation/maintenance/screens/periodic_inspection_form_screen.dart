import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/data/models/inspection_form_model.dart';
import 'package:gelismis_asansor_projesi/src/data/repositories/inspection_repository_impl.dart';
import 'package:gelismis_asansor_projesi/src/presentation/widgets/audio_visual_notes_widget.dart';
import 'package:signature/signature.dart';

class PeriodicInspectionFormScreen extends ConsumerStatefulWidget {
  final String elevatorId;
  final String customerId;

  const PeriodicInspectionFormScreen({
    super.key,
    required this.elevatorId,
    required this.customerId,
  });

  @override
  ConsumerState<PeriodicInspectionFormScreen> createState() => _PeriodicInspectionFormScreenState();
}

class _PeriodicInspectionFormScreenState extends ConsumerState<PeriodicInspectionFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController brakeClearanceController = TextEditingController(text: '0.25');
  final TextEditingController cableWearController = TextEditingController(text: '4.0');
  final TextEditingController safetySpeedController = TextEditingController(text: '1.25');
  final TextEditingController tempController = TextEditingController(text: '22.0');
  final TextEditingController notesController = TextEditingController();

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  String overallPassStatus = 'Pass'; // Pass, Warning, Fail
  bool isSaving = false;

  @override
  void dispose() {
    brakeClearanceController.dispose();
    cableWearController.dispose();
    safetySpeedController.dispose();
    tempController.dispose();
    notesController.dispose();
    _signatureController.dispose();
    super.dispose();
  }

  Future<void> _submitInspection() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSaving = true);

    try {
      final signatureBytes = await _signatureController.toPngBytes();
      final signatureBase64 = signatureBytes != null ? String.fromCharCodes(signatureBytes) : null;

      final form = InspectionFormModel(
        serverId: 'insp_${DateTime.now().millisecondsSinceEpoch}',
        elevatorId: int.parse(widget.elevatorId),
        customerId: int.parse(widget.customerId),
        inspectionDate: DateTime.now(),
        brakeClearanceMm: double.tryParse(brakeClearanceController.text),
        cableWearPercentage: double.tryParse(cableWearController.text),
        safetyGearTripSpeed: double.tryParse(safetySpeedController.text),
        machineRoomTemp: double.tryParse(tempController.text),
        overallPassStatus: overallPassStatus,
        technicianNotes: notesController.text.trim(),
        customerSignature: signatureBase64,
      );

      await ref.read(inspectionRepositoryProvider).saveInspection(form);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Periyodik Muayene ve Test Formu Başarıyla Kaydedildi')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata oluştu: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Periyodik Muayene & Test Formu'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kritik Parametre Ölçümleri',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: brakeClearanceController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Fren Balata Boşluğu (mm)',
                          suffixText: 'mm (Standart: 0.2 - 0.3mm)',
                        ),
                        validator: (val) => val == null || val.isEmpty ? 'Gerekli' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: cableWearController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Askı Halatı Çap İnceleme / Aşınma (%)',
                          suffixText: '% (Max %6.0)',
                        ),
                        validator: (val) => val == null || val.isEmpty ? 'Gerekli' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: safetySpeedController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Hız Regülatörü Atma Hızı (m/s)',
                          suffixText: 'm/s',
                        ),
                        validator: (val) => val == null || val.isEmpty ? 'Gerekli' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: tempController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Makine Dairesi Ortam Sıcaklığı (°C)',
                          suffixText: '°C (5°C - 40°C arası)',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Muayene Sonuç Değerlendirmesi',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: overallPassStatus,
                        decoration: const InputDecoration(labelText: 'Genel Durum Etiketi / Sonuç'),
                        items: const [
                          DropdownMenuItem(value: 'Pass', child: Text('YEŞİL ETİKET (Kullanıma Uygun)')),
                          DropdownMenuItem(value: 'Warning', child: Text('MAVİ / SARIDURUM (Hafif Kusurlu)')),
                          DropdownMenuItem(value: 'Fail', child: Text('KIRMIZI ETİKET (Tehlikeli / Servis Dışı)')),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => overallPassStatus = val);
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: notesController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Teknisyen Muayene Notları & Eksik Listesi',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Field Media Notes (Voice & Photo)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AudioVisualNotesWidget(
                    onChanged: (audios, photos) {
                      debugPrint('Eklenen medya: ${audios.length} ses, ${photos.length} foto');
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Müşteri / Bina Yetkilisi İmzası',
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () => _signatureController.clear(),
                            child: const Text('Temizle'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Signature(
                          controller: _signatureController,
                          backgroundColor: Colors.grey.shade50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: isSaving ? null : _submitInspection,
                child: isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Muayene Formunu Tamamla ve Kaydet'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
