import 'package:flutter/material.dart';
import 'egzersiz_ekrani.dart';
import 'besin_ekrani.dart';
import 'profil_ekrani.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  int _secilenIndeks = 0;
  
  final List<Widget> _ekranlar = [
    const EgzersizEkrani(),
    const BesinEkrani(),
    const ProfilEkrani(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ekranlar[_secilenIndeks],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _secilenIndeks,
            onTap: (indeks) => setState(() => _secilenIndeks = indeks),
            items: [
              _buildNavItem(Icons.fitness_center, 'Egzersiz'),
              _buildNavItem(Icons.restaurant_menu, 'Beslenme'),
              _buildNavItem(Icons.person, 'Profil'),
            ],
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _secilenIndeks == _getIndex(label) 
              ? Colors.green.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon),
      ),
      label: label,
    );
  }

  int _getIndex(String label) {
    switch (label) {
      case 'Egzersiz': return 0;
      case 'Beslenme': return 1;
      case 'Profil': return 2;
      default: return 0;
    }
  }

  Widget? _buildFloatingActionButton() {
    if (_secilenIndeks == 0) {
      return FloatingActionButton.extended(
        onPressed: () {
          // Hızlı antrenman başlatma
        },
        label: const Text('Hızlı Başlat'),
        icon: const Icon(Icons.play_arrow),
        backgroundColor: Colors.green,
      );
    } else if (_secilenIndeks == 1) {
      return FloatingActionButton(
        onPressed: () {
          // Besin ekleme
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      );
    }
    return null;
  }
} 