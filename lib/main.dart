import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'ekranlar/egzersiz_ekrani.dart';
import 'ekranlar/profil_ekrani.dart';
import 'servisler/kullanici_servisi.dart';
import 'servisler/egzersiz_servisi.dart';
import 'ekranlar/giris_ekrani.dart';
import 'servisler/besin_servisi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KullaniciServisi()),
        ChangeNotifierProvider(create: (_) => EgzersizServisi()),
        ChangeNotifierProvider(create: (_) => BesinServisi()),
      ],
      child: const FitnessApp(),
    ),
  );
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Takip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green,
          secondary: Colors.tealAccent,
          background: Colors.grey[100]!,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.green[100],
          foregroundColor: Colors.green[900],
        ),
        cardTheme: CardTheme(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.green[700],
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
      ),
      home: const GirisEkrani(),
    );
  }
}

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  int _secilenIndeks = 0;

  final List<Widget> _ekranlar = [
    const EgzersizEkrani(),
    const ProfilEkrani(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ekranlar[_secilenIndeks],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _secilenIndeks,
        onTap: (indeks) => setState(() => _secilenIndeks = indeks),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Antrenmanlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
