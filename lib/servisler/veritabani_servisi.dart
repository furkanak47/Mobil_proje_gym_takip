import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class VeritabaniServisi {
  static final VeritabaniServisi _ornek = VeritabaniServisi._internal();
  static Database? _veritabani;

  factory VeritabaniServisi() {
    return _ornek;
  }

  VeritabaniServisi._internal();

  Future<Database> veritabaniniAl() async {
    if (_veritabani != null) return _veritabani!;
    _veritabani = await _veritabaniniBaslat();
    return _veritabani!;
  }

  Future<Database> _veritabaniniBaslat() async {
    final veritabaniYolu = await getDatabasesPath();
    final yol = join(veritabaniYolu, 'fitnessTakip.db');

    return await openDatabase(
      yol,
      version: 1,
      onCreate: (db, versiyon) async {
        await db.execute('''
          CREATE TABLE kullanicilar (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ad TEXT,
            email TEXT UNIQUE,
            sifre TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE egzersizler (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            kullanici_id INTEGER,
            baslik TEXT,
            aciklama TEXT,
            tarih TEXT,
            FOREIGN KEY (kullanici_id) REFERENCES kullanicilar (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE besinler (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            kullanici_id INTEGER,
            ogun TEXT,
            kalori INTEGER,
            aciklama TEXT,
            tarih TEXT,
            FOREIGN KEY (kullanici_id) REFERENCES kullanicilar (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE hedefler (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            kullanici_id INTEGER,
            egzersiz_suresi INTEGER,
            gunluk_kalori INTEGER,
            FOREIGN KEY (kullanici_id) REFERENCES kullanicilar (id)
          )
        ''');
      },
    );
  }

  Future<int> kullaniciEkle(Map<String, dynamic> kullanici) async {
    final db = await veritabaniniAl();
    return await db.insert('kullanicilar', kullanici);
  }

  Future<Map<String, dynamic>?> kullaniciGetir(String email, String sifre) async {
    final db = await veritabaniniAl();
    List<Map<String, dynamic>> sonuc = await db.query(
      'kullanicilar',
      where: 'email = ? AND sifre = ?',
      whereArgs: [email, sifre],
    );
    return sonuc.isNotEmpty ? sonuc.first : null;
  }

  // Egzersiz işlemleri
  Future<int> egzersizEkle(Map<String, dynamic> egzersiz) async {
    final db = await veritabaniniAl();
    return await db.insert('egzersizler', egzersiz);
  }

  Future<List<Map<String, dynamic>>> egzersizleriGetir(int kullaniciId) async {
    final db = await veritabaniniAl();
    return await db.query(
      'egzersizler',
      where: 'kullanici_id = ?',
      whereArgs: [kullaniciId],
    );
  }

  // Besin işlemleri
  Future<int> besinEkle(Map<String, dynamic> besin) async {
    final db = await veritabaniniAl();
    return await db.insert('besinler', besin);
  }

  Future<List<Map<String, dynamic>>> besinleriGetir(int kullaniciId) async {
    final db = await veritabaniniAl();
    return await db.query(
      'besinler',
      where: 'kullanici_id = ?',
      whereArgs: [kullaniciId],
    );
  }

  Future<void> kaydet(String tablo, Map<String, dynamic> veri) async {
    final db = await veritabaniniAl();
    await db.insert(tablo, veri);
  }

  Future<List<Map<String, dynamic>>> sorgula(
    String tablo, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await veritabaniniAl();
    return await db.query(tablo, where: where, whereArgs: whereArgs);
  }
} 