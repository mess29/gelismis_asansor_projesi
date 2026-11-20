import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/presentation/auth/providers/auth_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AuthProvider'ı dinleyerek GoRouter'ın yönlendirme yapmasını bekliyoruz.
    // Bu ekran sadece bir "bekleme" ve marka gösterim ekranı olarak kalacak.
    // Tüm yönlendirme mantığı artık GoRouter'da.
    ref.watch(authProvider);

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Gelişmiş Asansör',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Yükleniyor...'),
          ],
        ),
      ),
    );
  }
}