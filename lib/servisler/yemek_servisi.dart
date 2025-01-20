import 'package:flutter/material.dart';

class YemekServisi extends ChangeNotifier {
  final Map<String, List<Yemek>> _kategoriler = {
    'Kahvaltılıklar': [
      Yemek('Yulaf Ezmesi', 150, 'porsiyon', 'protein: 6g, karbonhidrat: 27g'),
      Yemek('Haşlanmış Yumurta', 70, 'adet', 'protein: 6g, yağ: 5g'),
      Yemek('Tam Buğday Ekmek', 80, 'dilim', 'karbonhidrat: 15g'),
      Yemek('Beyaz Peynir', 60, 'porsiyon', 'protein: 4g, yağ: 5g'),
      Yemek('Menemen', 220, 'porsiyon', 'protein: 12g, yağ: 16g'),
      Yemek('Simit', 250, 'adet', 'karbonhidrat: 47g'),
      Yemek('Bal', 60, 'tatlı kaşığı', 'karbonhidrat: 17g'),
      Yemek('Reçel', 50, 'tatlı kaşığı', 'karbonhidrat: 13g'),
      Yemek('Zeytin', 45, '5 adet', 'yağ: 4.5g'),
      Yemek('Kaşarlı Omlet', 280, 'porsiyon', 'protein: 18g, yağ: 22g'),
      Yemek('Sucuklu Yumurta', 320, 'porsiyon', 'protein: 20g, yağ: 25g'),
      Yemek('Peynirli Börek', 280, 'adet', 'protein: 8g, karbonhidrat: 30g'),
      Yemek('Poğaça', 220, 'adet', 'karbonhidrat: 28g, yağ: 12g'),
      Yemek('Kahvaltılık Mısır Gevreği', 120, 'kase', 'karbonhidrat: 25g'),
      Yemek('Krep', 150, 'adet', 'karbonhidrat: 20g, protein: 4g'),
    ],
    'Ana Yemekler': [
      Yemek('Izgara Tavuk', 165, 'porsiyon', 'protein: 31g, yağ: 3.6g'),
      Yemek('Köfte', 250, 'porsiyon', 'protein: 26g, yağ: 17g'),
      Yemek('Somon', 208, 'porsiyon', 'protein: 22g, yağ: 13g'),
      Yemek('Mercimek Çorbası', 130, 'kase', 'protein: 9g, karbonhidrat: 20g'),
      Yemek('Karnıyarık', 320, 'porsiyon', 'protein: 15g, yağ: 18g'),
      Yemek('Mantı', 350, 'porsiyon', 'protein: 14g, karbonhidrat: 45g'),
      Yemek('Etli Pilav', 440, 'porsiyon', 'protein: 22g, karbonhidrat: 65g'),
      Yemek('İskender', 850, 'porsiyon', 'protein: 45g, yağ: 48g'),
      Yemek('Kuru Fasulye', 280, 'porsiyon', 'protein: 15g, karbonhidrat: 48g'),
      Yemek('Patlıcan Musakka', 340, 'porsiyon', 'protein: 18g, yağ: 22g'),
      Yemek('Etli Güveç', 380, 'porsiyon', 'protein: 25g, yağ: 20g'),
      Yemek('Tavuk Şiş', 280, 'porsiyon', 'protein: 32g, yağ: 12g'),
      Yemek('İmam Bayıldı', 260, 'porsiyon', 'yağ: 18g, karbonhidrat: 15g'),
      Yemek('Lahmacun', 300, 'adet', 'protein: 15g, karbonhidrat: 40g'),
      Yemek('Pide', 450, 'porsiyon', 'protein: 18g, karbonhidrat: 55g'),
      Yemek('Adana Kebap', 420, 'porsiyon', 'protein: 35g, yağ: 28g'),
      Yemek('Tavuklu Pilav', 380, 'porsiyon', 'protein: 25g, karbonhidrat: 45g'),
      Yemek('Zeytinyağlı Fasulye', 220, 'porsiyon', 'protein: 8g, karbonhidrat: 30g'),
      Yemek('Nohut Yemeği', 290, 'porsiyon', 'protein: 12g, karbonhidrat: 45g'),
    ],
    'Ara Öğünler': [
      Yemek('Muz', 105, 'adet', 'karbonhidrat: 27g'),
      Yemek('Badem', 160, 'avuç', 'protein: 6g, yağ: 14g'),
      Yemek('Yoğurt', 150, 'kase', 'protein: 13g, karbonhidrat: 12g'),
      Yemek('Protein Bar', 200, 'adet', 'protein: 20g, karbonhidrat: 25g'),
      Yemek('Ceviz', 180, '30g', 'protein: 4g, yağ: 18g'),
      Yemek('Fındık', 170, '30g', 'protein: 4g, yağ: 17g'),
      Yemek('Kuru Kayısı', 80, '4 adet', 'karbonhidrat: 20g'),
      Yemek('Kuru İncir', 100, '3 adet', 'karbonhidrat: 25g'),
      Yemek('Meyve Smoothie', 180, 'bardak', 'karbonhidrat: 35g'),
      Yemek('Havuç Stick', 30, 'porsiyon', 'karbonhidrat: 7g'),
      Yemek('Humus', 150, '50g', 'protein: 6g, yağ: 10g'),
    ],
    'Tatlılar': [
      Yemek('Sütlaç', 280, 'kase', 'karbonhidrat: 45g, protein: 6g'),
      Yemek('Baklava', 350, 'dilim', 'karbonhidrat: 40g, yağ: 20g'),
      Yemek('Kazandibi', 290, 'porsiyon', 'karbonhidrat: 42g, protein: 5g'),
      Yemek('Künefe', 460, 'porsiyon', 'karbonhidrat: 50g, yağ: 25g'),
      Yemek('Profiterol', 320, 'porsiyon', 'karbonhidrat: 35g, yağ: 18g'),
      Yemek('Dondurma', 150, 'top', 'karbonhidrat: 20g, yağ: 8g'),
    ],
    'İçecekler': [
      Yemek('Protein Shake', 120, 'bardak', 'protein: 24g, karbonhidrat: 3g'),
      Yemek('Yeşil Çay', 0, 'bardak', 'kalorisi yok'),
      Yemek('Ayran', 75, 'bardak', 'protein: 4g, yağ: 2g'),
      Yemek('Taze Sıkma Portakal', 110, 'bardak', 'karbonhidrat: 26g'),
      Yemek('Türk Kahvesi', 5, 'fincan', 'kalorisi çok düşük'),
      Yemek('Limonata', 120, 'bardak', 'karbonhidrat: 30g'),
      Yemek('Smoothie', 200, 'bardak', 'karbonhidrat: 35g, protein: 5g'),
      Yemek('Soğuk Çay', 80, 'bardak', 'karbonhidrat: 20g'),
      Yemek('Meyve Suyu', 140, 'bardak', 'karbonhidrat: 35g'),
    ],
  };

  final List<Yemek> _secilenYemekler = [];

  Map<String, List<Yemek>> get kategoriler => _kategoriler;
  List<Yemek> get secilenYemekler => _secilenYemekler;
  
  int get toplamKalori => _secilenYemekler.fold(0, (sum, item) => sum + item.kalori);

  void yemekEkle(Yemek yemek) {
    _secilenYemekler.add(yemek);
    notifyListeners();
  }

  void yemekCikar(Yemek yemek) {
    _secilenYemekler.remove(yemek);
    notifyListeners();
  }

  void sepetiTemizle() {
    _secilenYemekler.clear();
    notifyListeners();
  }

  List<Yemek> yemekAra(String aramaMetni) {
    if (aramaMetni.isEmpty) {
      List<Yemek> tumYemekler = [];
      _kategoriler.forEach((kategori, yemekler) {
        tumYemekler.addAll(yemekler);
      });
      return tumYemekler;
    }

    List<Yemek> sonuclar = [];
    for (var kategori in _kategoriler.values) {
      sonuclar.addAll(
        kategori.where((yemek) =>
            yemek.ad.toLowerCase().contains(aramaMetni.toLowerCase()) ||
            yemek.besinDegerleri.toLowerCase().contains(aramaMetni.toLowerCase())),
      );
    }
    
    sonuclar.sort((a, b) => a.kalori.compareTo(b.kalori));
    return sonuclar;
  }
}

class Yemek {
  final String ad;
  final int kalori;
  final String birim;
  final String besinDegerleri;

  Yemek(this.ad, this.kalori, this.birim, this.besinDegerleri);
} 