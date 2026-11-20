class InspectionFormModel {
  int? id;
  String serverId;
  int elevatorId;
  int customerId;
  DateTime inspectionDate;
  
  double? brakeClearanceMm;
  double? cableWearPercentage;
  double? safetyGearTripSpeed;
  double? machineRoomTemp;

  String overallPassStatus; // Pass, Warning, Fail
  String? technicianNotes;
  String? customerSignature; // Base64 png or path
  bool isSynced;
  DateTime? lastUpdatedLocal;

  InspectionFormModel({
    this.id,
    required this.serverId,
    required this.elevatorId,
    required this.customerId,
    required this.inspectionDate,
    this.brakeClearanceMm,
    this.cableWearPercentage,
    this.safetyGearTripSpeed,
    this.machineRoomTemp,
    this.overallPassStatus = 'Pass',
    this.technicianNotes,
    this.customerSignature,
    this.isSynced = false,
    this.lastUpdatedLocal,
  });
}
