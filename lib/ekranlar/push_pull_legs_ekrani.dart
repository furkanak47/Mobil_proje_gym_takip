import 'package:flutter/material.dart';

class PushPullLegsEkrani extends StatelessWidget {
  const PushPullLegsEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Pull Legs'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          _gunKarti(
            context,
            'Push (Pazartesi/Perşembe)',
            [
              _egzersizSatiri('Bench Press', '4 set x 8-12 tekrar'),
              _egzersizSatiri('Shoulder Press', '4 set x 8-12 tekrar'),
              _egzersizSatiri('Incline Press', '3 set x 10-12 tekrar'),
              _egzersizSatiri('Lateral Raise', '3 set x 12-15 tekrar'),
              _egzersizSatiri('Triceps Extension', '3 set x 12-15 tekrar'),
            ],
          ),
          _gunKarti(
            context,
            'Pull (Salı/Cuma)',
            [
              _egzersizSatiri('Deadlift', '4 set x 6-8 tekrar'),
              _egzersizSatiri('Pull-ups', '4 set x maksimum'),
              _egzersizSatiri('Barbell Row', '3 set x 10-12 tekrar'),
              _egzersizSatiri('Face Pull', '3 set x 12-15 tekrar'),
              _egzersizSatiri('Biceps Curl', '3 set x 12-15 tekrar'),
            ],
          ),
          _gunKarti(
            context,
            'Legs (Çarşamba/Cumartesi)',
            [
              _egzersizSatiri('Squat', '4 set x 8-12 tekrar'),
              _egzersizSatiri('Romanian Deadlift', '4 set x 10-12 tekrar'),
              _egzersizSatiri('Leg Press', '3 set x 12-15 tekrar'),
              _egzersizSatiri('Leg Extension', '3 set x 12-15 tekrar'),
              _egzersizSatiri('Calf Raise', '4 set x 15-20 tekrar'),
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