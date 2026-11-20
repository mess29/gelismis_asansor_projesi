import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelismis_asansor_projesi/src/core/database/app_database.dart';
import 'package:gelismis_asansor_projesi/src/core/database/database_provider.dart';
import 'package:gelismis_asansor_projesi/src/data/models/error_code_model.dart';
import 'package:gelismis_asansor_projesi/src/domain/repositories/error_code_repository.dart';

final errorCodeRepositoryProvider = Provider<ErrorCodeRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ErrorCodeRepositoryImpl(db);
});

class ErrorCodeRepositoryImpl implements ErrorCodeRepository {
  final AppDatabase db;

  ErrorCodeRepositoryImpl(this.db);

  @override
  Future<List<ErrorCodeModel>> searchErrorCodes({String? brand, String? query}) async {
    var dbQuery = db.select(db.errorCodes);
    if (brand != null && brand.isNotEmpty && brand != 'Tümü') {
      dbQuery = dbQuery..where((t) => t.brand.equals(brand));
    }
    
    final rows = await dbQuery.get();

    if (rows.isEmpty) {
      await _seedDefaultErrorCodes();
      return searchErrorCodes(brand: brand, query: query);
    }

    var list = rows.map((r) => ErrorCodeModel(
      id: r.id,
      brand: r.brand,
      code: r.code,
      title: r.title,
      rootCause: r.rootCause,
      solutionSteps: r.solutionSteps,
    )).toList();

    if (query != null && query.trim().isNotEmpty) {
      final q = query.toLowerCase();
      list = list.where((e) => 
        e.code.toLowerCase().contains(q) ||
        e.title.toLowerCase().contains(q) ||
        e.rootCause.toLowerCase().contains(q)
      ).toList();
    }

    return list;
  }

  @override
  Future<List<TroubleshootingGuideModel>> getTroubleshootingGuides({String? brand, String? category}) async {
    var dbQuery = db.select(db.troubleshootingGuides);
    if (brand != null && brand.isNotEmpty && brand != 'Tümü') {
      dbQuery = dbQuery..where((t) => t.brand.equals(brand));
    }
    if (category != null && category.isNotEmpty && category != 'Tümü') {
      dbQuery = dbQuery..where((t) => t.category.equals(category));
    }

    final rows = await dbQuery.get();

    if (rows.isEmpty) {
      await _seedDefaultGuides();
      return getTroubleshootingGuides(brand: brand, category: category);
    }

    return rows.map((r) => TroubleshootingGuideModel(
      id: r.id,
      brand: r.brand,
      category: r.category,
      title: r.title,
      symptom: r.symptom,
      diagnosticSteps: r.diagnosticSteps,
    )).toList();
  }

  Future<void> _seedDefaultErrorCodes() async {
    final seeds = [
      ErrorCodeModel(
        brand: 'Arkel',
        code: 'Er-01',
        title: 'Kat Kapısı Açılmadı / Kilit Devresi Kesik',
        rootCause: '140 kapı fiş devresi veya 130 emniyet devresi kesintiye uğramış.',
        solutionSteps: [
          'Emniyet devresi gerilimini (110V AC/24V DC) kontrol edin.',
          'Durak kapısı mekanik kilidinin takılıp takılmadığını inceleyin.',
          'Kapı fiş kontaklarında oksitlenme veya gevşeme olup olmadığını kontrol edin.',
          'Pano klemenslerindeki 130-140 girişlerini multimetre ile ölçün.'
        ],
      ),
      ErrorCodeModel(
        brand: 'Arkel',
        code: 'Er-15',
        title: 'Hız Regülatörü Veya Alt/Üst Limit Açtı',
        rootCause: 'Kabin alt veya üst zorunlu yavaşlama sınır şalterini geçti ya da regülatör kilitlendi.',
        solutionSteps: [
          'Kabin durumunu revizyon moduna alarak kontrol edin.',
          'Alt/üst sınır bi-stabil şalterlerini ve mıknatıs mesafelerini kontrol edin.',
          'Hız regülatörü makarasının ve halatının serbest döndüğünden emin olun.',
          'Pano üzerindeki 817/818 yavaşlama girdilerini kontrol edin.'
        ],
      ),
      ErrorCodeModel(
        brand: 'Mikrolift',
        code: 'E-04',
        title: 'Fren Açma Hata Kontrolü (Brake Feedback Error)',
        rootCause: 'Fren bobinleri açılmadı veya fren izleme mikro-şalteri sinyal vermedi.',
        solutionSteps: [
          'Fren kontaktörünün çekip çekmediğini gözlemleyin.',
          'Fren bobin direncini voltaj varken ve yokken ölçün.',
          'Fren mekanik balata aralığını (0.2mm - 0.3mm) sentil çakısı ile kontrol edin.',
          'Fren mikroşalter bağlantılarını ve pano kart girişini doğrulayın.'
        ],
      ),
      ErrorCodeModel(
        brand: 'Aybey',
        code: 'Er-08',
        title: 'Motor Hareket Süresi Aşıldı (PTC / Motor Protection)',
        rootCause: 'Motor aşırı ısındı ya da halat kayması sebebiyle tanımlı maksimum çalışma süresi (MTO) aşıldı.',
        solutionSteps: [
          'Makine dairesi ortam sıcaklığını ve motor fanını kontrol edin.',
          'Motor klemens kutusundaki PTC termistör direncini ölçün.',
          'Tahrik kasnağı ve askı halatlarında yağlanma veya kayma olup olmadığını kontrol edin.',
          'Parametre menüsünden maksimum motor çalışma süresini (MTO) gözden geçirin.'
        ],
      ),
      ErrorCodeModel(
        brand: 'Fuji',
        code: 'LU',
        title: 'Düşük Voltaj / Şebeke Çökmesi (Under Voltage)',
        rootCause: 'Giriş şebeke voltajı tolerans sınırının (380V %15) altına düştü.',
        solutionSteps: [
          'Ana şebeke şalteri girişinde 3 faz R-S-T voltajlarını ölçün.',
          'Şebeke nötr hattında gevşeklik veya faz dengesizliği kontrolü yapın.',
          'İnverter DC otobüs (DC Bus) voltaj seviyesini ekrandan izleyin.'
        ],
      ),
    ];

    for (final e in seeds) {
      await db.into(db.errorCodes).insert(
        ErrorCodesCompanion.insert(
          brand: e.brand,
          code: e.code,
          title: e.title,
          rootCause: e.rootCause,
          solutionSteps: Value(e.solutionSteps),
        ),
      );
    }
  }

  Future<void> _seedDefaultGuides() async {
    final guides = [
      TroubleshootingGuideModel(
        brand: 'Genel',
        category: 'Kapı',
        title: 'Kat Kapısı Kapanıyor Fakat Kabin Hareket Etmiyor',
        symptom: 'Kabin katta bekliyor, çağrı alıyor ama kalkış yapmıyor.',
        diagnosticSteps: [
          'Pano üzerindeki emniyet devresi ledlerini (120-130-140) sırasıyla kontrol edin.',
          '130 (Fiş) ledi yanmıyorsa kapı kanat kontaklarını kontrol edin.',
          '140 (Kilit) ledi yanmıyorsa fiş girmiş fakat kilit fişi tam basmıyor demektir, kilit yayını ayarlayın.',
          'Fren kontaktörüne gerilim gelip gelmediğini kontrol edin.'
        ],
      ),
      TroubleshootingGuideModel(
        brand: 'Genel',
        category: 'Motor',
        title: 'Kalkışta Şiddetli Sarsıntı Veya Titreşim',
        symptom: 'Kabin kalkış anında vuruntu yapıyor veya kalkamadan frene geçiyor.',
        diagnosticSteps: [
          'İnverter kalkış rampa süresini ve tork artırma (Torque Boost) parametresini inceleyin.',
          'Fren açma gecikmesi (Brake Open Delay) süresinin motor tork üretmeden önce açılmadığından emin olun.',
          'Motor klemens bağlantılarının gevşek olmadığını ve U-V-W faz sırasını doğrulayın.',
          'Kasnak yataklarında veya kılavuz patenlerde aşırı sıkışma olup olmadığını kontrol edin.'
        ],
      ),
      TroubleshootingGuideModel(
        brand: 'Genel',
        category: 'Kuyu',
        title: 'Kabin Kat Seviyesinde Durmuyor (Seviye Kayması)',
        symptom: 'Kabin kat hizasının 3-5 cm üstünde veya altında duruyor.',
        diagnosticSteps: [
          'Kuyu durdurucu bi-stabil şalterlerin ve kat bayraklarının (mıknatıs) pozisyonunu ölçün.',
          'Fren balata aşınmasını ve fren yay tansiyonunu kontrol edin.',
          'İnverter duruş yavaşlama rampasını ve frekans seviyesini ayarlayın.'
        ],
      ),
    ];

    for (final g in guides) {
      await db.into(db.troubleshootingGuides).insert(
        TroubleshootingGuidesCompanion.insert(
          brand: g.brand,
          category: g.category,
          title: g.title,
          symptom: g.symptom,
          diagnosticSteps: Value(g.diagnosticSteps),
        ),
      );
    }
  }
}
