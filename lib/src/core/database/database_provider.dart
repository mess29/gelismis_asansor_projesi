import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/core/database/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
