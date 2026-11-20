import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/core/database/app_database.dart';
import 'package:gelismis_asansor_projesi/src/core/database/database_provider.dart';

final syncManagerProvider = Provider<SyncManager>((ref) {
  final db = ref.watch(databaseProvider);
  final manager = SyncManager(db);
  manager.initConnectivityListener();
  ref.onDispose(() => manager.dispose());
  return manager;
});

class SyncManager {
  final AppDatabase db;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  bool _isProcessing = false;

  SyncManager(this.db);

  void initConnectivityListener() {
    _connectivitySub = Connectivity().onConnectivityChanged.listen((results) {
      final hasConnection = results.any((r) => r != ConnectivityResult.none);
      if (hasConnection) {
        debugPrint('[SyncManager] Internet bağlantısı sağlandı, kuyruk işleniyor...');
        processQueue();
      }
    });
  }

  void dispose() {
    _connectivitySub?.cancel();
  }

  Future<void> addToQueue(String actionType, Map<String, dynamic> payload) async {
    await db.into(db.syncQueue).insert(
      SyncQueueCompanion.insert(
        actionType: actionType,
        payloadJson: json.encode(payload),
        createdAt: DateTime.now(),
        status: const Value('pending'),
      ),
    );
    debugPrint('[SyncManager] Yeni işlem senkronizasyon kuyruğuna eklendi: $actionType');
    
    // İnternet varsa hemen dene
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity.any((r) => r != ConnectivityResult.none)) {
      processQueue();
    }
  }

  Future<void> processQueue() async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      final pendingItems = await (db.select(db.syncQueue)
        ..where((tbl) => tbl.status.equals('pending') | tbl.status.equals('failed'))
        ..where((tbl) => tbl.retryCount.isSmallerThan(const Constant(5))))
        .get();

      if (pendingItems.isEmpty) {
        _isProcessing = false;
        return;
      }

      debugPrint('[SyncManager] ${pendingItems.length} adet bekleyen senkronizasyon işleniyor...');

      for (final item in pendingItems) {
        try {
          await (db.update(db.syncQueue)..where((t) => t.id.equals(item.id)))
              .write(const SyncQueueCompanion(status: Value('syncing')));

          // Simüle edilmiş sunucu senkronizasyon işlemi
          await _executeSyncAction(item.actionType, json.decode(item.payloadJson));

          await (db.update(db.syncQueue)..where((t) => t.id.equals(item.id)))
              .write(const SyncQueueCompanion(status: Value('completed')));
              
          debugPrint('[SyncManager] İşlem tamamlandı (ID: ${item.id})');
        } catch (e) {
          debugPrint('[SyncManager] Hata oluştu (ID: ${item.id}): $e');
          await (db.update(db.syncQueue)..where((t) => t.id.equals(item.id)))
              .write(SyncQueueCompanion(
                status: const Value('failed'),
                retryCount: Value(item.retryCount + 1),
                lastError: Value(e.toString()),
              ));
        }
      }
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _executeSyncAction(String actionType, Map<String, dynamic> payload) async {
    // Gerçek API entegrasyonu (Dio / Firebase) burada tetiklenir
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<List<SyncQueueData>> getPendingQueue() async {
    return (db.select(db.syncQueue)
      ..where((tbl) => tbl.status.equals('pending') | tbl.status.equals('syncing')))
      .get();
  }
}
