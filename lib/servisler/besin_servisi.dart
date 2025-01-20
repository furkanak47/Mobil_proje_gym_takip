import 'package:flutter/foundation.dart';
import '../veriler/besinler.dart';
import 'veritabani_servisi.dart';

class BesinServisi extends ChangeNotifier {
  final _veritabaniServisi = VeritabaniServisi();
  final List<Map<String, dynamic>> _gunlukBesinler = [];
  final Map<String, List<Besin>> _secilenBesinler = {
    'Kahvaltı': [],
    'Öğle Yemeği': [],
    'Akşam Yemeği': [],
    'Ara Öğünler': [],
  };
  
  List<Map<String, dynamic>> get gunlukBesinler => _gunlukBesinler;
  List<Besin> getOgunBesinleri(String ogun) => _secilenBesinler[ogun] ?? [];
  
  int get toplamKalori => _secilenBesinler.values
      .expand((besinler) => besinler)
      .fold<int>(0, (toplam, besin) => toplam + besin.kalori);

  Future<void> besinEkle(String ogun, Besin besin) async {
    _secilenBesinler[ogun]?.add(besin);
    await _veritabaniServisi.kaydet('besinler', {
      'ogun': ogun,
      'besin': besin,
      'tarih': DateTime.now().toIso8601String(),
    });
    notifyListeners();
  }

  void besinCikar(String ogun, Besin besin) {
    _secilenBesinler[ogun]?.remove(besin);
    notifyListeners();
  }

  int ogunKalorisi(String ogun) => _secilenBesinler[ogun]?.fold<int>(
    0, 
    (toplam, besin) => toplam + besin.kalori,
  ) ?? 0;

  Map<String, double> ogunMakrolari(String ogun) {
    final besinler = _secilenBesinler[ogun] ?? [];
    return {
      'protein': besinler.fold(0.0, (t, b) => t + (b.makrolar['protein'] ?? 0.0)),
      'karbonhidrat': besinler.fold(0.0, (t, b) => t + (b.makrolar['karbonhidrat'] ?? 0.0)),
      'yağ': besinler.fold(0.0, (t, b) => t + (b.makrolar['yağ'] ?? 0.0)),
    };
  }

  double get toplamProtein => _secilenBesinler.values
      .expand((besinler) => besinler)
      .fold(0.0, (toplam, besin) => toplam + (besin.makrolar['protein'] ?? 0.0));

  double get toplamKarbonhidrat => _secilenBesinler.values
      .expand((besinler) => besinler)
      .fold(0.0, (toplam, besin) => toplam + (besin.makrolar['karbonhidrat'] ?? 0.0));

  double get toplamYag => _secilenBesinler.values
      .expand((besinler) => besinler)
      .fold(0.0, (toplam, besin) => toplam + (besin.makrolar['yağ'] ?? 0.0));
} 