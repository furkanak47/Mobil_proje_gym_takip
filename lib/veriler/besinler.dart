class Besin {
  final String ad;
  final String miktar;
  final int kalori;
  final Map<String, double> makrolar; // protein, karbonhidrat, yağ

  const Besin({
    required this.ad,
    required this.miktar,
    required this.kalori,
    required this.makrolar,
  });
}

final kahvaltiliklar = [
  Besin(
    ad: 'Yulaf',
    miktar: '100g',
    kalori: 389,
    makrolar: {'protein': 16.9, 'karbonhidrat': 66.3, 'yağ': 6.9},
  ),
  Besin(
    ad: 'Yumurta',
    miktar: '1 adet',
    kalori: 70,
    makrolar: {'protein': 6.3, 'karbonhidrat': 0.6, 'yağ': 4.8},
  ),
  Besin(
    ad: 'Tam Buğday Ekmeği',
    miktar: '1 dilim',
    kalori: 80,
    makrolar: {'protein': 4.0, 'karbonhidrat': 15.0, 'yağ': 1.0},
  ),
  Besin(
    ad: 'Beyaz Peynir',
    miktar: '30g',
    kalori: 75,
    makrolar: {'protein': 6.0, 'karbonhidrat': 1.0, 'yağ': 6.0},
  ),
  Besin(
    ad: 'Zeytin',
    miktar: '5 adet',
    kalori: 45,
    makrolar: {'protein': 0.4, 'karbonhidrat': 0.3, 'yağ': 4.5},
  ),
  Besin(
    ad: 'Bal',
    miktar: '1 yemek kaşığı',
    kalori: 64,
    makrolar: {'protein': 0.1, 'karbonhidrat': 17.3, 'yağ': 0},
  ),
  Besin(
    ad: 'Reçel',
    miktar: '1 yemek kaşığı',
    kalori: 50,
    makrolar: {'protein': 0, 'karbonhidrat': 13.0, 'yağ': 0},
  ),
  Besin(
    ad: 'Süt',
    miktar: '1 bardak',
    kalori: 122,
    makrolar: {'protein': 8.0, 'karbonhidrat': 12.3, 'yağ': 4.8},
  ),
  Besin(
    ad: 'Kaşar Peyniri',
    miktar: '30g',
    kalori: 114,
    makrolar: {'protein': 7.0, 'karbonhidrat': 0.9, 'yağ': 9.3},
  ),
  Besin(
    ad: 'Domates',
    miktar: '1 orta boy',
    kalori: 22,
    makrolar: {'protein': 1.1, 'karbonhidrat': 4.8, 'yağ': 0.2},
  ),
  Besin(
    ad: 'Salatalık',
    miktar: '1 orta boy',
    kalori: 8,
    makrolar: {'protein': 0.3, 'karbonhidrat': 1.9, 'yağ': 0.1},
  ),
  Besin(
    ad: 'Tereyağı',
    miktar: '1 yemek kaşığı',
    kalori: 102,
    makrolar: {'protein': 0.1, 'karbonhidrat': 0, 'yağ': 11.5},
  ),
  Besin(
    ad: 'Yeşil Zeytin',
    miktar: '5 adet',
    kalori: 35,
    makrolar: {'protein': 0.3, 'karbonhidrat': 0.2, 'yağ': 3.7},
  ),
  Besin(
    ad: 'Ceviz',
    miktar: '2 adet',
    kalori: 52,
    makrolar: {'protein': 1.2, 'karbonhidrat': 1.1, 'yağ': 5.2},
  ),
  Besin(
    ad: 'Kayısı',
    miktar: '2 adet',
    kalori: 34,
    makrolar: {'protein': 0.5, 'karbonhidrat': 8.4, 'yağ': 0.1},
  ),
];

final anaYemekler = [
  Besin(
    ad: 'Izgara Tavuk Göğsü',
    miktar: '100g',
    kalori: 165,
    makrolar: {'protein': 31.0, 'karbonhidrat': 0.0, 'yağ': 3.6},
  ),
  Besin(
    ad: 'Pirinç Pilavı',
    miktar: '100g',
    kalori: 130,
    makrolar: {'protein': 2.7, 'karbonhidrat': 28.0, 'yağ': 0.3},
  ),
  Besin(
    ad: 'Mercimek Çorbası',
    miktar: '1 kase',
    kalori: 230,
    makrolar: {'protein': 11.0, 'karbonhidrat': 40.0, 'yağ': 3.0},
  ),
  Besin(
    ad: 'Izgara Köfte',
    miktar: '100g',
    kalori: 200,
    makrolar: {'protein': 26.0, 'karbonhidrat': 0.0, 'yağ': 11.0},
  ),
  Besin(
    ad: 'Zeytinyağlı Fasulye',
    miktar: '100g',
    kalori: 150,
    makrolar: {'protein': 7.0, 'karbonhidrat': 20.0, 'yağ': 7.0},
  ),
  Besin(
    ad: 'Bulgur Pilavı',
    miktar: '100g',
    kalori: 83,
    makrolar: {'protein': 3.1, 'karbonhidrat': 18.6, 'yağ': 0.2},
  ),
  Besin(
    ad: 'Izgara Somon',
    miktar: '100g',
    kalori: 208,
    makrolar: {'protein': 22.0, 'karbonhidrat': 0.0, 'yağ': 13.0},
  ),
  Besin(
    ad: 'Mantı',
    miktar: '100g',
    kalori: 215,
    makrolar: {'protein': 8.0, 'karbonhidrat': 30.0, 'yağ': 7.0},
  ),
  Besin(
    ad: 'Karnıyarık',
    miktar: '1 porsiyon',
    kalori: 320,
    makrolar: {'protein': 13.0, 'karbonhidrat': 25.0, 'yağ': 18.0},
  ),
  Besin(
    ad: 'Etli Nohut',
    miktar: '100g',
    kalori: 180,
    makrolar: {'protein': 15.0, 'karbonhidrat': 21.0, 'yağ': 5.0},
  ),
  Besin(
    ad: 'Ispanak Yemeği',
    miktar: '100g',
    kalori: 130,
    makrolar: {'protein': 5.0, 'karbonhidrat': 15.0, 'yağ': 6.0},
  ),
  Besin(
    ad: 'Tavuk Şiş',
    miktar: '100g',
    kalori: 175,
    makrolar: {'protein': 28.0, 'karbonhidrat': 0.0, 'yağ': 6.0},
  ),
  Besin(
    ad: 'İmam Bayıldı',
    miktar: '1 porsiyon',
    kalori: 250,
    makrolar: {'protein': 5.0, 'karbonhidrat': 20.0, 'yağ': 16.0},
  ),
  Besin(
    ad: 'Kuru Fasulye',
    miktar: '100g',
    kalori: 170,
    makrolar: {'protein': 9.0, 'karbonhidrat': 25.0, 'yağ': 4.0},
  ),
  Besin(
    ad: 'Tavuklu Salata',
    miktar: '1 porsiyon',
    kalori: 220,
    makrolar: {'protein': 25.0, 'karbonhidrat': 10.0, 'yağ': 9.0},
  ),
];

final atistirmaliklar = [
  Besin(
    ad: 'Badem',
    miktar: '30g',
    kalori: 164,
    makrolar: {'protein': 6.0, 'karbonhidrat': 6.1, 'yağ': 14.0},
  ),
  Besin(
    ad: 'Muz',
    miktar: '1 orta boy',
    kalori: 105,
    makrolar: {'protein': 1.3, 'karbonhidrat': 27.0, 'yağ': 0.3},
  ),
  Besin(
    ad: 'Yoğurt',
    miktar: '1 kase',
    kalori: 150,
    makrolar: {'protein': 8.5, 'karbonhidrat': 11.0, 'yağ': 8.0},
  ),
  Besin(
    ad: 'Kuru Üzüm',
    miktar: '30g',
    kalori: 90,
    makrolar: {'protein': 0.9, 'karbonhidrat': 22.0, 'yağ': 0.1},
  ),
  Besin(
    ad: 'Protein Bar',
    miktar: '1 adet',
    kalori: 200,
    makrolar: {'protein': 20.0, 'karbonhidrat': 25.0, 'yağ': 5.0},
  ),
  Besin(
    ad: 'Havuç',
    miktar: '1 orta boy',
    kalori: 25,
    makrolar: {'protein': 0.6, 'karbonhidrat': 6.0, 'yağ': 0.1},
  ),
  Besin(
    ad: 'Fındık',
    miktar: '30g',
    kalori: 178,
    makrolar: {'protein': 4.3, 'karbonhidrat': 4.7, 'yağ': 17.2},
  ),
  Besin(
    ad: 'Elma',
    miktar: '1 orta boy',
    kalori: 95,
    makrolar: {'protein': 0.5, 'karbonhidrat': 25.0, 'yağ': 0.3},
  ),
  Besin(
    ad: 'Proteinli Süt',
    miktar: '250ml',
    kalori: 160,
    makrolar: {'protein': 20.0, 'karbonhidrat': 12.0, 'yağ': 3.0},
  ),
  Besin(
    ad: 'Kuru Kayısı',
    miktar: '30g',
    kalori: 80,
    makrolar: {'protein': 1.0, 'karbonhidrat': 20.0, 'yağ': 0.1},
  ),
  Besin(
    ad: 'Meyve Smoothie',
    miktar: '300ml',
    kalori: 200,
    makrolar: {'protein': 4.0, 'karbonhidrat': 45.0, 'yağ': 1.0},
  ),
  Besin(
    ad: 'Hindistan Cevizi',
    miktar: '30g',
    kalori: 190,
    makrolar: {'protein': 2.0, 'karbonhidrat': 7.0, 'yağ': 18.0},
  ),
  Besin(
    ad: 'Kefir',
    miktar: '200ml',
    kalori: 120,
    makrolar: {'protein': 6.0, 'karbonhidrat': 12.0, 'yağ': 6.0},
  ),
  Besin(
    ad: 'Chia Tohumu',
    miktar: '15g',
    kalori: 70,
    makrolar: {'protein': 3.0, 'karbonhidrat': 6.0, 'yağ': 4.5},
  ),
  Besin(
    ad: 'Yeşil Smoothie',
    miktar: '300ml',
    kalori: 150,
    makrolar: {'protein': 5.0, 'karbonhidrat': 30.0, 'yağ': 2.0},
  ),
]; 