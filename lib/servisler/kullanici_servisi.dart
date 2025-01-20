import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'veritabani_servisi.dart';

class KullaniciServisi extends ChangeNotifier {
  static final KullaniciServisi _ornek = KullaniciServisi._internal();
  final _veritabaniServisi = VeritabaniServisi();
  
  // Web için kayıtlı kullanıcıları tutacak liste
  final List<Map<String, dynamic>> _webKullanicilari = [];
  Map<String, dynamic>? _aktifKullanici;
  Map<String, dynamic>? _profilBilgileri;
  
  int _hedefKalori = 2000; // Varsayılan değer
  
  factory KullaniciServisi() {
    return _ornek;
  }

  KullaniciServisi._internal();

  Map<String, dynamic>? get aktifKullanici => _aktifKullanici;
  Map<String, dynamic>? get profilBilgileri => _profilBilgileri;

  int get hedefKalori => _hedefKalori;

  Kullanici? _kullanici;
  
  Kullanici? get kullanici => _kullanici;

  Future<bool> girisYap(String email, String sifre) async {
    try {
      if (!kIsWeb) {
        // Desktop/Mobile için veritabanı kontrolü
        _aktifKullanici = await _veritabaniServisi.kullaniciGetir(email, sifre);
      } else {
        // Web için kayıtlı kullanıcıları kontrol et
        _aktifKullanici = _webKullanicilari.firstWhere(
          (k) => k['email'] == email && k['sifre'] == sifre,
          orElse: () => {},
        );
        if (_aktifKullanici?.isEmpty ?? true) {
          _aktifKullanici = null;
        }
      }
      notifyListeners();
      return _aktifKullanici != null;
    } catch (e) {
      print('Giriş yaparken hata: $e');
      return false;
    }
  }

  Future<bool> kayitOl(String ad, String email, String sifre) async {
    try {
      print('Kayıt başlıyor: $ad, $email');
      if (!kIsWeb) {
        final id = await _veritabaniServisi.kullaniciEkle({
          'ad': ad,
          'email': email,
          'sifre': sifre,
        });
        _aktifKullanici = {
          'id': id,
          'ad': ad,
          'email': email,
        };
      } else {
        final yeniKullanici = {
          'id': DateTime.now().millisecondsSinceEpoch,
          'ad': ad,
          'email': email,
          'sifre': sifre,  // Web için şifreyi de saklıyoruz
        };
        _webKullanicilari.add(yeniKullanici);
        _aktifKullanici = yeniKullanici;
      }
      notifyListeners();
      return true;
    } catch (e) {
      print('KullaniciServisi kayitOl hatası: $e');
      return false;
    }
  }

  void cikisYap() {
    _aktifKullanici = null;
    notifyListeners();
  }

  void profilBilgileriniGuncelle(Map<String, dynamic> bilgiler) {
    _profilBilgileri = bilgiler;
    notifyListeners();
  }

  // Profil bilgileri dolduruldu mu kontrolü
  bool get profilDolu => _kullanici != null;

  // Günlük kalori ihtiyacını hesapla
  int gunlukKaloriIhtiyaciHesapla() {
    if (_kullanici == null) return 2000; // Varsayılan değer

    final kilo = _kullanici!.kilo;
    final boy = _kullanici!.boy;
    final yas = _kullanici!.yas;
    
    // Harris-Benedict denklemi (erkek için)
    // Kadın için farklı formül eklenebilir
    double bmr = 88.362 + (13.397 * kilo) + (4.799 * boy) - (5.677 * yas);
    
    // Orta düzey aktivite için 1.55 ile çarpıyoruz
    return (bmr * 1.55).round();
  }

  void hedefKaloriGuncelle(int kalori) {
    _hedefKalori = kalori;
    notifyListeners();
  }

  // Profil bilgilerini güncelle ve kalori hesapla
  void kullaniciBilgileriniGuncelle({
    required String ad,
    required int yas,
    required double kilo,
    required double boy,
  }) {
    final gunlukKaloriHedefi = gunlukKaloriIhtiyaciHesapla();
    
    _kullanici = Kullanici(
      ad: ad,
      yas: yas,
      kilo: kilo,
      boy: boy,
      gunlukKaloriHedefi: gunlukKaloriHedefi,
    );
    notifyListeners();
  }
}

class Kullanici {
  final String ad;
  final int yas;
  final double kilo;
  final double boy;
  final int gunlukKaloriHedefi;

  Kullanici({
    required this.ad,
    required this.yas,
    required this.kilo,
    required this.boy,
    required this.gunlukKaloriHedefi,
  });
} 