class Antrenman {
  final String baslik;
  final String hedef;
  final String sure;
  final String zorluk;
  final List<Hareket> hareketler;
  final List<String>? notlar;
  final List<String>? gunler;
  final int yakilanKalori;

  Antrenman({
    required this.baslik,
    required this.hedef,
    required this.sure,
    required this.zorluk,
    required this.hareketler,
    this.notlar,
    this.gunler,
    this.yakilanKalori = 0,
  });
}

class Hareket {
  final String ad;
  final String setAdet;
  final String aciklama;
  final List<String>? ipuclari;
  final String? videoUrl;

  Hareket({
    required this.ad,
    required this.setAdet,
    required this.aciklama,
    this.ipuclari,
    this.videoUrl,
  });
} 