import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gelismis_asansor_projesi/src/data/models/elevator_model.dart';
import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';
import 'package:gelismis_asansor_projesi/src/presentation/maintenance/providers/maintenance_provider.dart';
import 'package:gelismis_asansor_projesi/src/presentation/widgets/app_logo_title.dart';


final elevatorDetailProvider = FutureProvider.autoDispose.family<ElevatorModel?, int>((ref, id) async {
  final repository = ref.watch(customerRepositoryProvider);
  return repository.getElevatorById(id);
});

class ElevatorDetailScreen extends ConsumerWidget {
  final String elevatorId;
  final String? customerId; // Optional because sometimes we might access from QR directly? Ideally required if routing structure enforces it.
                            // Given the router structure, it seems required. But let's check if QR scanner routes here.
                            // QR scanner might route here. 

  const ElevatorDetailScreen({super.key, required this.elevatorId, this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = int.tryParse(elevatorId);
    if (id == null) return const Scaffold(body: Center(child: Text('Geçersiz ID')));

    final elevatorAsync = ref.watch(elevatorDetailProvider(id));
    final maintenanceHistoryAsync = ref.watch(maintenanceHistoryForElevatorProvider(id));
    
    bool isMaintainedThisMonth = false;
    final historyList = maintenanceHistoryAsync.valueOrNull;
    if (historyList != null && historyList.isNotEmpty) {
      final now = DateTime.now();
      for (final record in historyList) {
        if (record.year == now.year && record.month == now.month) {
          isMaintainedThisMonth = true;
          break;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const AppLogoTitle(title: Text('Asansör Kimlik')),
        actions: elevatorAsync.valueOrNull != null
            ? [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                     if (customerId != null) {
                        context.goNamed(
                          'add_elevator', 
                          pathParameters: {'customerId': customerId!},
                          extra: elevatorAsync.value!
                        );
                      } else {
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Müşteri bilgisi bulunamadı.')));
                      }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Sil?'),
                        content: const Text('Bu asansör kaydını silmek istediğinize emin misiniz?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('İptal'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: FilledButton.styleFrom(backgroundColor: Colors.red),
                            child: const Text('Sil'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true && context.mounted) {
                      await ref
                          .read(customerRepositoryProvider)
                          .deleteElevator(elevatorAsync.value!.id!);
                      if (context.mounted) {
                        context.pop(); // Detaydan çık
                      }
                    }
                  },
                ),
              ]
            : null,
      ),
      body: elevatorAsync.when(
        data: (elevator) {
           if (elevator == null) return const Center(child: Text('Bulunamadı.'));

           return SingleChildScrollView(
             padding: const EdgeInsets.all(16),
             child: Column(
               children: [
                 _buildHeader(context, elevator),
                 const SizedBox(height: 16),
                 _buildSpecsCard(elevator),
                 const SizedBox(height: 16),
                 _buildHistoryButton(context, elevator),
                 const SizedBox(height: 8),
                 _buildDocsButton(context),
                 const SizedBox(height: 24),
                 _buildActionButtons(context, elevator, isMaintainedThisMonth),
               ],
             ),
           );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Hata: $err')),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ElevatorModel elevator) {
    return Column(
      children: [
        Icon(Icons.elevator, size: 64, color: Theme.of(context).primaryColor),
        const SizedBox(height: 8),
        Text(elevator.code, style: Theme.of(context).textTheme.headlineLarge),
        if (elevator.name != null && elevator.name!.isNotEmpty)
          Text(elevator.name!, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Chip(
          label: Text(_getTagLabel(elevator.tagColor)), 
          backgroundColor: _getColor(elevator.tagColor),
        ),
      ],
    );
  }

  String _getTagLabel(ElevatorTagColor color) {
    switch (color) {
      case ElevatorTagColor.red: return 'KIRMIZI ETİKET';
      case ElevatorTagColor.yellow: return 'SARI ETİKET';
      case ElevatorTagColor.blue: return 'MAVİ ETİKET';
      case ElevatorTagColor.green: return 'YEŞİL ETİKET';
      case ElevatorTagColor.none: return 'ETİKET GİRİLMEDİ';
    }
  }

  Color _getColor(ElevatorTagColor color) {
    switch (color) {
      case ElevatorTagColor.red: return Colors.red.shade200;
      case ElevatorTagColor.yellow: return Colors.yellow.shade200;
      case ElevatorTagColor.blue: return Colors.blue.shade200;
      case ElevatorTagColor.green: return Colors.green.shade200;
      case ElevatorTagColor.none: return Colors.grey.shade300;
    }
  }

  Widget _buildSpecsCard(ElevatorModel elevator) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _row('Tip', _getElevatorTypeName(elevator)),
            if (elevator.idNumber != null && elevator.idNumber!.isNotEmpty)
               _row('Kimlik No', elevator.idNumber!),
            if (elevator.driveType != null && elevator.driveType!.isNotEmpty)
               _row('Tahrik Tipi', elevator.driveType!),
            _row('Durak Sayısı', '${elevator.stops ?? "-"}'),
            _row('Kapasite (Kişi)', '${elevator.capacityPerson ?? "-"} Kişi'),
            _row('Kapasite (Kg)', '${elevator.capacityWeight ?? "-"} Kg'),
            _row('Hız', '${elevator.speed ?? "-"} m/s'),
            _row('Son Muayene', '15.05.2025'), // Mock
          ],
        ),
      ),
    );
  }

  String _getElevatorTypeName(ElevatorModel elevator) {
    switch (elevator.type) {
      case ElevatorType.human: return 'İnsan Asansörü';
      case ElevatorType.freight: return 'Yük Asansörü';
      case ElevatorType.stretcher: return 'Sedye Asansörü';
      case ElevatorType.moncharge: return 'Monşarj';
      case ElevatorType.vehicle: return 'Araç Asansörü';
      case ElevatorType.service: return 'Servis Asansörü';
      case ElevatorType.disabled: return 'Engelli Asansörü';
      case ElevatorType.platform: return 'Platform';
      case ElevatorType.other: return 'Diğer (${elevator.usageTypeDetail ?? "-"})';
    }
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildHistoryButton(BuildContext context, ElevatorModel elevator) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      leading: const Icon(Icons.history),
      title: const Text('Bakım & Arıza Geçmişi (Logbook)'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if (customerId != null) {
          context.pushNamed('elevator_logbook', pathParameters: {
            'customerId': customerId!,
            'elevatorId': elevator.id.toString(),
          });
        }
      },
    );
  }
  
  Widget _buildDocsButton(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      leading: const Icon(Icons.library_books),
      title: const Text('Teknik Kütüphane (Şemalar)'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // TODO: Navigate to docs
      },
    );
  }

  Widget _buildActionButtons(BuildContext context, ElevatorModel elevator, bool isMaintainedThisMonth) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () async {
                   if (isMaintainedThisMonth) {
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bu asansörün bu aya ait bakımı zaten yapılmış!')));
                     return;
                   }
                   if (customerId != null) {
                     context.pushNamed('maintenance_form', pathParameters: {
                       'customerId': customerId!,
                       'elevatorId': elevator.id.toString(),
                     });
                   } else {
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Müşteri ID bulunamadı, form açılamıyor.')));
                   }
                },
                icon: const Icon(Icons.build),
                label: const Text('BAKIM BAŞLAT'),
                style: isMaintainedThisMonth 
                  ? FilledButton.styleFrom(backgroundColor: Colors.grey)
                  : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: () async {
                   if (customerId != null) {
                     context.pushNamed('fault_form', pathParameters: {
                       'customerId': customerId!,
                       'elevatorId': elevator.id.toString(),
                     });
                   } else {
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Müşteri ID bulunamadı, form açılamıyor.')));
                   }
                },
                icon: const Icon(Icons.warning),
                label: const Text('ARIZA KAYDI'),
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              if (customerId != null) {
                context.pushNamed('inspection_form', pathParameters: {
                  'customerId': customerId!,
                  'elevatorId': elevator.id.toString(),
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Müşteri ID bulunamadı.')));
              }
            },
            icon: const Icon(Icons.verified),
            label: const Text('PERİYODİK MUAYENE & TEST FORMU'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
