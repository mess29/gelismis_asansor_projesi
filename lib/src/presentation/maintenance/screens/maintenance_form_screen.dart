import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gelismis_asansor_projesi/src/data/models/elevator_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/maintenance_model.dart';
import 'package:gelismis_asansor_projesi/src/presentation/maintenance/providers/maintenance_provider.dart';
import 'package:gelismis_asansor_projesi/src/core/ads/ad_manager.dart';

class MaintenanceFormScreen extends ConsumerStatefulWidget {
  final String elevatorId;
  final String customerId;

  const MaintenanceFormScreen({super.key, required this.elevatorId, required this.customerId});

  @override
  ConsumerState<MaintenanceFormScreen> createState() => _MaintenanceFormScreenState();
}

class _MaintenanceFormScreenState extends ConsumerState<MaintenanceFormScreen> {
  final TextEditingController notesController = TextEditingController();
  final TextEditingController noteInputController = TextEditingController();
  
  List<MaintenanceCheckItem> _checklist = [];
  List<CarryOverNote> _carryOverNotes = [];
  final List<UsedMaterial> _usedMaterials = [];
  bool isInitializing = true;
  
  void _addMaterial() {
    setState(() {
      _usedMaterials.add(UsedMaterial(name: '', quantity: 1, price: 0.0));
    });
  }

  @override
  void initState() {
    super.initState();
    _fillDefaultChecklist();
    // After build start fetching elevator pending tasks
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPendingTasks();
    });
  }

  void _fillDefaultChecklist() {
    final Map<String, List<String>> categorizedDefaults = {
      'Kuyu Dibi': [
        'Tamponlar',
        'Kuyu dibi temizliği',
        'Hız regülatörü germe makarası',
        'Asansör boşluğu aydınlatması',
      ],
      'Kabin': [
        'Seyir kalitesi testi (Tam kalkış)',
        'Asansör kabini hareket kumandaları ve göstergeleri',
        'Kapı açma kumandaları',
        'Asansör kabininin normal aydınlatılması',
        'Kapı yön değiştirme tertibatı',
        'Çift yönlü haberleşme araçlarının kontrolü',
        'Kabin içi ve üstü temizliği',
        'Asansör kabin kapısı kilitleri, mekanizması ve panelleri',
        'Güvenlik tertibatı / yukarı yönde aşırı hız koruma araçları',
        'Acil alarm tertibatı ve diğer bataryaların kontrolü',
        'Asansör kabini / karşı ağırlık kılavuzları ve patenleri',
      ],
      'Katlar': [
        'Durak kapıları ve kat kapı rayları',
        'Katta durma hassasiyeti',
        'Durak hareket kumandaları ve göstergeleri',
        'Güvenlik işaretleri / resimli uyarı işaretleri',
        'Durak kapısı kilitleri, mekanizması ve panelleri',
      ],
      'Makine Dairesi': [
        'Dişli kutusu ve Tahrik motoru',
        'Tahrik kasnağı ve Fren',
        'Hız regülatörü',
        'Elektrik tesisatı ve elektrik güvenlik tertibatı',
        'Kumanda panosu ve motor hareket süresi sınırlayıcı',
        'Makine dairesi temizliği',
        'Askı halatları / zincirleri ve saptırma makaraları',
      ],
    };

    _checklist = [];
    categorizedDefaults.forEach((category, items) {
      for (var itemTitle in items) {
        _checklist.add(MaintenanceCheckItem(
          title: itemTitle,
          category: category,
          isChecked: false,
        ));
      }
    });
  }

  Future<void> _loadPendingTasks() async {
    final elevatorId = int.parse(widget.elevatorId);
    final repo = ref.read(maintenanceRepositoryProvider).customerRepository;
    
    final elevator = await repo.getElevatorById(elevatorId);
    
    if (elevator != null) {
      if (elevator.pendingMaintenanceTasks.isNotEmpty) {
        setState(() {
          _carryOverNotes = elevator.pendingMaintenanceTasks.map((t) => CarryOverNote(text: t.text, isCompleted: t.isChecked)).toList();
        });
      }
    }
    
    setState(() {
      isInitializing = false;
    });
  }

  @override
  void dispose() {
    notesController.dispose();
    noteInputController.dispose();
    super.dispose();
  }

  Future<void> _submitMaintenance() async {
    final cId = int.parse(widget.customerId);
    final eId = int.parse(widget.elevatorId);
    
    final now = DateTime.now();
    
    final maintenance = MaintenanceModel(
      serverId: 'local_${now.millisecondsSinceEpoch}',
      maintenanceDate: now,
      year: now.year,
      month: now.month,
      notes: notesController.text,
    );
    maintenance.checklist = _checklist;
    maintenance.carryOverNotes = _carryOverNotes;
    
    // Yalnızca geçerli isim ve tutarı olan malzemeleri al
    maintenance.usedMaterials = _usedMaterials
        .where((m) => m.name != null && m.name!.trim().isNotEmpty && m.price > 0)
        .toList();

    // Tamamlanmayan notları tekrar asansöre TickableNote olarak aktar
    List<TickableNote> newPending = _carryOverNotes
      .where((note) => !note.isCompleted)
      .map((n) => TickableNote()..text = n.text..isChecked = false)
      .toList();

    await ref.read(maintenanceRepositoryProvider).saveMaintenanceRecord(maintenance, cId, eId, newPending);

    if (mounted) {
      ref.read(adManagerProvider).showInterstitialAd(
        onAdDismissed: () {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bakım başarıyla tamamlandı!')));
            context.pop();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isInitializing) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bakım Formu'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Aylık Bakım Kontrol Listesi',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._buildCategorizedChecklist(),
            const SizedBox(height: 24),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Kullanılan Malzemeler',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                FilledButton.icon(
                  onPressed: _addMaterial,
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text('Malzeme Ekle'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const Text(
                'Eklenen malzemelerin toplam tutarı otomatik olarak cari hesaba "Borç" olarak yansıtılacaktır.',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 12),
            if (_usedMaterials.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.inventory_2_outlined, color: Colors.grey, size: 32),
                    SizedBox(height: 8),
                    Text('Kullanılan malzeme yok.', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            else
              Column(
                children: List.generate(_usedMaterials.length, (index) {
                  final material = _usedMaterials[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                child: Text('${index + 1}', style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: 'Malzeme Açıklaması',
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  onChanged: (val) => material.name = val,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _usedMaterials.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                          const Divider(height: 1),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Miktar',
                                    isDense: true,
                                    prefixIcon: const Icon(Icons.tag, size: 18),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  onChanged: (val) => material.quantity = int.tryParse(val) ?? 1,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  decoration: InputDecoration(
                                    labelText: 'Birim Fiyat (TL)',
                                    isDense: true,
                                    prefixIcon: const Icon(Icons.payments_outlined, size: 18),
                                    suffixText: '₺',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  onChanged: (val) {
                                    material.price = double.tryParse(val.replaceAll(',', '.')) ?? 0.0;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            
            const SizedBox(height: 24),

            Text('Devreden / İleriye Dönük Görevler', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const Text('Eğer bu bakımda tamamlanmayan (parça bekleme vb.) işler varsa kutucukları DOLDURMAYIN. Tamamladıklarınızı İŞARETLEYİN! İşaretlenmeyenler sonraki bakıma devredecektir.'),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  if (_carryOverNotes.isEmpty)
                     const Padding(padding: EdgeInsets.all(16), child: Text('Devreden not bulunmuyor.')),
                  ..._carryOverNotes.map((note) {
                    return CheckboxListTile(
                      title: Text(note.text ?? ''),
                      value: note.isCompleted,
                      onChanged: (val) {
                        setState(() {
                          note.isCompleted = val ?? false;
                        });
                      },
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: noteInputController,
                    decoration: const InputDecoration(labelText: 'Yeni Devreden/Görev Notu Ekle'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.blue, size: 32),
                  onPressed: () {
                    if (noteInputController.text.isNotEmpty) {
                      setState(() {
                        _carryOverNotes.add(CarryOverNote(text: noteInputController.text, isCompleted: false));
                        noteInputController.clear();
                      });
                    }
                  }
                )
              ],
            ),
            const SizedBox(height: 24),
            Text('Genel Bakım Notu', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: notesController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Müşteriye veya teknik ekibe bildirmek istediğiniz ek açıklamalar...',
              ),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _submitMaintenance,
              icon: const Icon(Icons.save),
              label: const Text('BAKIMI TAMAMLA VE KAYDET'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCategorizedChecklist() {
    final Map<String, List<MaintenanceCheckItem>> groups = {};
    for (var item in _checklist) {
      final cat = item.category ?? 'Genel';
      groups.putIfAbsent(cat, () => []).add(item);
    }

    return groups.entries.map((entry) {
      final allChecked = entry.value.every((i) => i.isChecked);

      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
          leading: Icon(
            allChecked ? Icons.check_circle : Icons.pending_actions,
            color: allChecked ? Colors.green : Colors.orange,
          ),
          children: entry.value.map((item) {
            return CheckboxListTile(
              title: Text(item.title ?? ''),
              value: item.isChecked,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (val) {
                setState(() {
                  item.isChecked = val ?? false;
                });
              },
            );
          }).toList(),
        ),
      );
    }).toList();
  }
}
