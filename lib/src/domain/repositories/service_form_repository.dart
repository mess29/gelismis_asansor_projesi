import 'package:gelismis_asansor_projesi/src/data/models/service_form_model.dart';

abstract class ServiceFormRepository {
  /// Belirtilen iş emrine ait formu getirir. Yoksa null döner.
  Future<ServiceFormModel?> getForm(String workOrderId);

  /// Servis formunu veritabanına kaydeder (veya günceller).
  Future<void> saveForm(ServiceFormModel form);
}