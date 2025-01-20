import 'package:flutter/foundation.dart';
import 'veritabani_servisi.dart';
import '../modeller/antrenman.dart';

class EgzersizServisi extends ChangeNotifier {
  final _veritabaniServisi = VeritabaniServisi();
  DateTime? _baslangicZamani;
  Antrenman? _aktifAntrenman;
  final List<Antrenman> _antrenmanGecmisi = [];
  int _gunlukYakilanKalori = 0;
  List<Map<String, dynamic>> _tamamlananAntrenmanlar = [];

  // Getters
  DateTime? get baslangicZamani => _baslangicZamani;
  List<Antrenman> get antrenmanGecmisi => _antrenmanGecmisi;
  int get gunlukYakilanKalori => _gunlukYakilanKalori;
  bool get antrenmanDevamEdiyor => _baslangicZamani != null;
  Antrenman? get aktifAntrenman => _aktifAntrenman;

  // İstatistik getters
  int get aylikAntrenmanSayisi => _tamamlananAntrenmanlar.length;
  int get aylikToplamSure => _tamamlananAntrenmanlar.fold(
    0,
    (toplam, antrenman) => toplam + ((antrenman['sure'] as int?) ?? 0),
  );
  int get aylikYakilanKalori => _tamamlananAntrenmanlar.fold(
    0,
    (toplam, antrenman) => toplam + ((antrenman['kalori'] as int?) ?? 0),
  );

  // Antrenman metodları
  void antrenmanBaslat(Antrenman antrenman) {
    _baslangicZamani = DateTime.now();
    _aktifAntrenman = antrenman;
    notifyListeners();
  }

  Future<void> antrenmanBitir({required int yakilanKalori}) async {
    if (_baslangicZamani != null && _aktifAntrenman != null) {
      final sure = DateTime.now().difference(_baslangicZamani!).inMinutes;
      
      _gunlukYakilanKalori += yakilanKalori;
      _antrenmanGecmisi.add(
        Antrenman(
          baslik: _aktifAntrenman!.baslik,
          sure: '$sure dk',
          zorluk: _aktifAntrenman!.zorluk,
          hedef: _aktifAntrenman!.hedef,
          yakilanKalori: yakilanKalori,
          hareketler: _aktifAntrenman!.hareketler,
        ),
      );

      final antrenmanVerisi = {
        'program': _aktifAntrenman!.baslik,
        'sure': sure,
        'kalori': yakilanKalori,
        'tarih': _baslangicZamani!.toIso8601String(),
      };

      try {
        await _veritabaniServisi.kaydet('tamamlanan_antrenmanlar', antrenmanVerisi);
        _tamamlananAntrenmanlar = [..._tamamlananAntrenmanlar, antrenmanVerisi];
        
        // Aktif antrenmanı sıfırla
        _baslangicZamani = null;
        _aktifAntrenman = null;
        
        notifyListeners();
      } catch (e) {
        print('Antrenman kaydedilirken hata: $e');
        rethrow; // Hatayı yukarı fırlat
      }
    }
  }

  Future<void> aylikAntrenmanlariYukle() async {
    final buAy = DateTime.now();
    final baslangic = DateTime(buAy.year, buAy.month, 1);
    final bitis = DateTime(buAy.year, buAy.month + 1, 0);

    final sonuc = await _veritabaniServisi.sorgula(
      'tamamlanan_antrenmanlar',
      where: 'tarih BETWEEN ? AND ?',
      whereArgs: [baslangic.toIso8601String(), bitis.toIso8601String()],
    );
    
    _tamamlananAntrenmanlar = sonuc;
    notifyListeners();
  }
} 