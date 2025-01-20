import 'package:flutter/material.dart';

class BeslenmeProgramiServisi extends ChangeNotifier {
  final Map<String, List<Map<String, dynamic>>> _yemekler = {
    'Kahvaltı': [
      {
        'ad': 'Yulaf Ezmesi',
        'porsiyon': '100g',
        'kalori': 350,
        'protein': 13,
        'karbonhidrat': 60,
        'yag': 7,
      },
      {
        'ad': 'Omlet',
        'porsiyon': '2 yumurta',
        'kalori': 280,
        'protein': 18,
        'karbonhidrat': 2,
        'yag': 22,
      },
      // Diğer kahvaltı seçenekleri
    ],
    'Öğle': [
      {
        'ad': 'Tavuk Göğsü',
        'porsiyon': '200g',
        'kalori': 330,
        'protein': 62,
        'karbonhidrat': 0,
        'yag': 7,
      },
      // Diğer öğle yemeği seçenekleri
    ],
    'Akşam': [
      {
        'ad': 'Somon',
        'porsiyon': '200g',
        'kalori': 412,
        'protein': 46,
        'karbonhidrat': 0,
        'yag': 28,
      },
      // Diğer akşam yemeği seçenekleri
    ],
    'Ara Öğün': [
      {
        'ad': 'Protein Shake',
        'porsiyon': '1 scoop',
        'kalori': 120,
        'protein': 24,
        'karbonhidrat': 3,
        'yag': 1,
      },
      // Diğer ara öğün seçenekleri
    ],
  };

  Map<String, List<Map<String, dynamic>>> get yemekler => _yemekler;
} 