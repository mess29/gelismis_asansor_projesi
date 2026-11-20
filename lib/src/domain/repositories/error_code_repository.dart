import 'package:gelismis_asansor_projesi/src/data/models/error_code_model.dart';

abstract class ErrorCodeRepository {
  Future<List<ErrorCodeModel>> searchErrorCodes({String? brand, String? query});
  Future<List<TroubleshootingGuideModel>> getTroubleshootingGuides({String? brand, String? category});
}
