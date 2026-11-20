import 'package:gelismis_asansor_projesi/src/data/models/inspection_form_model.dart';

abstract class InspectionRepository {
  Future<List<InspectionFormModel>> getInspectionsForElevator(int elevatorId);
  Future<void> saveInspection(InspectionFormModel form);
}
