import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:gelismis_asansor_projesi/src/presentation/maintenance/providers/maintenance_provider.dart';
import 'package:gelismis_asansor_projesi/src/presentation/faults/providers/fault_provider.dart';

enum LogbookItemType { maintenance, faultActive, faultResolved }

class LogbookItem {
  final DateTime date;
  final LogbookItemType type;
  final String title;
  final String description;

  LogbookItem({required this.date, required this.type, required this.title, required this.description});
}

final logbookProvider = FutureProvider.autoDispose.family<List<LogbookItem>, int>((ref, elevatorId) async {
  final maintenanceHistory = await ref.watch(maintenanceHistoryForElevatorProvider(elevatorId).future);
  final activeFaults = await ref.watch(activeFaultsForElevatorProvider(elevatorId).future);
  final resolvedFaults = await ref.watch(faultHistoryForElevatorProvider(elevatorId).future);

  List<LogbookItem> items = [];

  for (final m in maintenanceHistory) {
    items.add(LogbookItem(
      date: m.maintenanceDate,
      type: LogbookItemType.maintenance,
      title: 'Periyodik Bakım',
      description: m.notes != null && m.notes!.isNotEmpty ? m.notes! : 'Genel bakım notu girilmemiş.',
    ));
  }

  for (final f in activeFaults) {
    items.add(LogbookItem(
      date: f.reportedDate,
      type: LogbookItemType.faultActive,
      title: 'Arıza Bildirildi (Açık)',
      description: f.description,
    ));
  }

  for (final f in resolvedFaults) {
    items.add(LogbookItem(
      date: f.resolvedDate ?? f.reportedDate,
      type: LogbookItemType.faultResolved,
      title: 'Arıza Giderildi',
      description: 'Arıza: ${f.description}\nÇözüm: ${f.technicianNote ?? "Belirtilmemiş"}',
    ));
  }

  // Sort descending (newest first)
  items.sort((a, b) => b.date.compareTo(a.date));

  return items;
});

class ElevatorLogbookScreen extends ConsumerWidget {
  final String elevatorId;
  final String customerId;

  const ElevatorLogbookScreen({super.key, required this.elevatorId, required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eId = int.tryParse(elevatorId);
    if (eId == null) {
      return const Scaffold(body: Center(child: Text('Geçersiz Asansör Kimliği')));
    }

    final logbookAsync = ref.watch(logbookProvider(eId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bakım & Arıza Geçmişi'),
      ),
      body: logbookAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Bu asansöre ait henüz herhangi bir bakım veya arıza kaydı bulunmamaktadır.'),
              ),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildLogbookCard(context, item);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Geçmiş yüklenirken hata oluştu: $err')),
      ),
    );
  }

  Widget _buildLogbookCard(BuildContext context, LogbookItem item) {
    IconData icon;
    Color iconColor;
    Color cardColor;

    switch (item.type) {
      case LogbookItemType.maintenance:
        icon = Icons.build_circle;
        iconColor = Colors.blue.shade700;
        cardColor = Colors.blue.shade50;
        break;
      case LogbookItemType.faultActive:
        icon = Icons.warning;
        iconColor = Colors.red.shade800;
        cardColor = Colors.red.shade50;
        break;
      case LogbookItemType.faultResolved:
        icon = Icons.check_circle;
        iconColor = Colors.green.shade700;
        cardColor = Colors.green.shade50;
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(fontWeight: FontWeight.bold, color: iconColor, fontSize: 16),
                        ),
                      ),
                      Text(
                        DateFormat('dd.MM.yyyy HH:mm').format(item.date),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
