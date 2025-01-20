import 'package:flutter/material.dart';

class FullBodyProgramEkrani extends StatelessWidget {
  const FullBodyProgramEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Body Program'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          _gunKarti(
            context,
            'Pazartesi',
            [
              _egzersizSatiri('Squat', '4 set x 10 tekrar'),
              _egzersizSatiri('Bench Press', '4 set x 10 tekrar'),
              _egzersizSatiri('Barbell Row', '4 set x 10 tekrar'),
              _egzersizSatiri('Shoulder Press', '3 set x 12 tekrar'),
              _egzersizSatiri('Pull-ups', '3 set x maksimum'),
            ],
          ),
          _gunKarti(
            context,
            'Çarşamba',
            [
              _egzersizSatiri('Deadlift', '4 set x 8 tekrar'),
              _egzersizSatiri('Dips', '4 set x maksimum'),
              _egzersizSatiri('Lat Pulldown', '4 set x 12 tekrar'),
              _egzersizSatiri('Leg Press', '3 set x 15 tekrar'),
            ],
          ),
          _gunKarti(
            context,
            'Cuma',
            [
              _egzersizSatiri('Romanian Deadlift', '4 set x 10 tekrar'),
              _egzersizSatiri('Incline Press', '4 set x 12 tekrar'),
              _egzersizSatiri('Cable Row', '4 set x 12 tekrar'),
              _egzersizSatiri('Lateral Raise', '3 set x 15 tekrar'),
            ],
          ),
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