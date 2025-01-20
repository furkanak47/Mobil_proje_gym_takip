import 'package:flutter/material.dart';

class BolgeselProgramEkrani extends StatelessWidget {
  const BolgeselProgramEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bölgesel Program'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          _gunKarti(
            context,
            'Pazartesi - Göğüs',
            [
              _egzersizSatiri('Bench Press', '4 set x 12 tekrar'),
              _egzersizSatiri('Incline DB Press', '3 set x 12 tekrar'),
              _egzersizSatiri('Cable Flyes', '3 set x 15 tekrar'),
              _egzersizSatiri('Dips', '3 set x maksimum'),
            ],
          ),
          _gunKarti(
            context,
            'Salı - Sırt',
            [
              _egzersizSatiri('Lat Pulldown', '4 set x 12 tekrar'),
              _egzersizSatiri('Barbell Row', '4 set x 12 tekrar'),
              _egzersizSatiri('Cable Row', '3 set x 12 tekrar'),
              _egzersizSatiri('Face Pull', '3 set x 15 tekrar'),
            ],
          ),
          _gunKarti(
            context,
            'Çarşamba - Bacak',
            [
              _egzersizSatiri('Squat', '4 set x 10 tekrar'),
              _egzersizSatiri('Leg Press', '4 set x 12 tekrar'),
              _egzersizSatiri('Leg Extension', '3 set x 15 tekrar'),
              _egzersizSatiri('Calf Raise', '4 set x 20 tekrar'),
            ],
          ),
          _gunKarti(
            context,
            'Perşembe - Omuz',
            [
              _egzersizSatiri('Military Press', '4 set x 10 tekrar'),
              _egzersizSatiri('Lateral Raise', '4 set x 12 tekrar'),
              _egzersizSatiri('Front Raise', '3 set x 12 tekrar'),
              _egzersizSatiri('Rear Delt Fly', '3 set x 15 tekrar'),
            ],
          ),
          _gunKarti(
            context,
            'Cuma - Kol',
            [
              _egzersizSatiri('Barbell Curl', '4 set x 12 tekrar'),
              _egzersizSatiri('Triceps Pushdown', '4 set x 12 tekrar'),
              _egzersizSatiri('Hammer Curl', '3 set x 12 tekrar'),
              _egzersizSatiri('Overhead Extension', '3 set x 15 tekrar'),
            ],
          ),
          // Diğer günler...
        ],
      ),
    );
  }

  Widget _gunKarti(BuildContext context, String baslik, List<Widget> egzersizler) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ExpansionTile(
        title: Text(
          baslik,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: egzersizler,
            ),
          ),
        ],
      ),
    );
  }

  Widget _egzersizSatiri(String ad, String detay) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.fitness_center, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              ad,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            detay,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
} 