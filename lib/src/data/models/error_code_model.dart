class ErrorCodeModel {
  int? id;
  String brand; // Arkel, Mikrolift, Aybey, Fuji, etc.
  String code; // Er-01, Er-15, E-04
  String title;
  String rootCause;
  List<String> solutionSteps;

  ErrorCodeModel({
    this.id,
    required this.brand,
    required this.code,
    required this.title,
    required this.rootCause,
    required this.solutionSteps,
  });
}

class TroubleshootingGuideModel {
  int? id;
  String brand;
  String category; // Motor, Kapı, Kuyu, Kumanda Pano, Fren
  String title;
  String symptom;
  List<String> diagnosticSteps;

  TroubleshootingGuideModel({
    this.id,
    required this.brand,
    required this.category,
    required this.title,
    required this.symptom,
    required this.diagnosticSteps,
  });
}
