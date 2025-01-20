import 'package:flutter/material.dart';

class EvProgramiEkrani extends StatelessWidget {
  const EvProgramiEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evde Antrenman'),
      ),
      body: ListView(
        children: [
          _gunKarti(
            context,
            'Pazartesi - Üst Vücut',
            [
              _egzersizSatiri('Şınav', '4 set x maksimum'),
              _egzersizSatiri('Dips', '3 set x maksimum'),
              _egzersizSatiri('Pike Push-up', '3 set x maksimum'),
              _egzersizSatiri('Diamond Push-up', '3 set x maksimum'),
            ],
          ),
          _gunKarti(
            context,
            'Salı - Core & Kardiyo',
            [
              _egzersizSatiri('Plank', '3 set x 45 saniye'),
              _egzersizSatiri('Mountain Climber', '3 set x 30 saniye'),
              _egzersizSatiri('Bisiklet Crunch', '3 set x 20 tekrar'),
              _egzersizSatiri('Burpee', '3 set x 10 tekrar'),
            ],
          ),
          _gunKarti(
            context,
            'Çarşamba - Alt Vücut',
            [
              _egzersizSatiri('Bodyweight Squat', '4 set x 20 tekrar'),
              _egzersizSatiri('Lunges', '3 set x 15 tekrar/bacak'),
              _egzersizSatiri('Calf Raise', '4 set x 25 tekrar'),
              _egzersizSatiri('Wall Sit', '3 set x 45 saniye'),
            ],
          ),
          _gunKarti(
            context,
            'Cuma - Full Body',
            [
              _egzersizSatiri('Pull-up/Negatif Pull-up', '3 set x maksimum'),
              _egzersizSatiri('Push-up', '3 set x maksimum'),
              _egzersizSatiri('Squat Jumps', '3 set x 15 tekrar'),
              _egzersizSatiri('Plank to Downward Dog', '3 set x 10 tekrar'),
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
        title: Text(baslik),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: egzersizler),
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
          Expanded(child: Text(ad)),
          Text(detay, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
} 