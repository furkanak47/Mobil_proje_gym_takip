import 'package:flutter/material.dart';

class EgzersizProgramiServisi extends ChangeNotifier {
  final Map<String, List<Map<String, dynamic>>> _programlar = {
    'Başlangıç': [
      {
        'gun': 'Pazartesi',
        'egzersizler': [
          {'ad': 'Bench Press', 'set': 3, 'tekrar': 10, 'kalori': 150},
          {'ad': 'Shoulder Press', 'set': 3, 'tekrar': 12, 'kalori': 120},
          {'ad': 'Push-ups', 'set': 3, 'tekrar': 15, 'kalori': 100},
        ]
      },
      {
        'gun': 'Çarşamba',
        'egzersizler': [
          {'ad': 'Squat', 'set': 3, 'tekrar': 12, 'kalori': 200},
          {'ad': 'Leg Press', 'set': 3, 'tekrar': 15, 'kalori': 180},
          {'ad': 'Lunges', 'set': 3, 'tekrar': 10, 'kalori': 120},
        ]
      },
      {
        'gun': 'Cuma',
        'egzersizler': [
          {'ad': 'Pull-ups', 'set': 3, 'tekrar': 8, 'kalori': 160},
          {'ad': 'Barbell Row', 'set': 3, 'tekrar': 12, 'kalori': 140},
          {'ad': 'Face Pull', 'set': 3, 'tekrar': 15, 'kalori': 100},
        ]
      },
    ],
    'Orta Seviye': [
      // Benzer yapıda daha zorlu programlar
    ],
    'İleri Seviye': [
      // Benzer yapıda profesyonel programlar
    ],
  };

  Map<String, List<Map<String, dynamic>>> get programlar => _programlar;
} 