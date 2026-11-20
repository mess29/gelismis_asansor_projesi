import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart'; // Add at top
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/core/database/app_database.dart';
import 'package:gelismis_asansor_projesi/src/core/database/database_provider.dart';
import 'package:gelismis_asansor_projesi/src/core/router/app_router.dart';
import 'package:gelismis_asansor_projesi/src/core/theme/app_theme.dart';
import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';

import 'package:intl/date_symbol_data_local.dart';
// Duplicate but fine

import 'package:firebase_core/firebase_core.dart';
import 'package:gelismis_asansor_projesi/firebase_options.dart';
import 'package:gelismis_asansor_projesi/src/core/ads/ad_manager.dart';

Future<void> main() async {
  // Flutter binding'lerini başlat
  WidgetsFlutterBinding.ensureInitialized();
  
  // AdManager'ı başlat
  final adManager = AdManager();
  await adManager.init();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await initializeDateFormatting('tr_TR', null);
  
  // Ekran yönünü dikey olarak kilitle
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // 1. Veritabanı Servisini Başlat
  try {
    debugPrint('Uygulama başlatılıyor...');
    final appDb = AppDatabase();
    debugPrint('Drift AppDatabase başarıyla ayarlandı.');
    
    // 3. Müşteri Verilerini Kontrol Et ve Aylık Aidatları İşle
    if (!kIsWeb) {
      final customerRepo = CustomerRepository(appDb);
      await customerRepo.checkAndApplyMonthlyFees();
      debugPrint('Aylık aidat kontrolleri tamamlandı.');
    } else {
      debugPrint('Web platformu tespit edildi.');
    }

    runApp(
      ProviderScope(
        overrides: [
          adManagerProvider.overrideWithValue(adManager),
          databaseProvider.overrideWithValue(appDb),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e, stack) {
    debugPrint('KRİTİK HATA: Uygulama başlatılamadı: $e');
    debugPrint(stack.toString());
    
    // Hata durumunda bile en azından hata ekranı gösteren bir uygulama başlat
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SelectableText('Uygulama Başlatılamadı:\n$e'),
          ),
        ),
      ),
    );
  }
}

// DatabaseProvider override edilir
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Gelişmiş Asansör',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(),
      routerConfig: router,
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaler: mediaQueryData.textScaler.clamp(
              minScaleFactor: 0.8,
              maxScaleFactor: 1.1,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}