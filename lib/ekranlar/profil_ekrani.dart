import 'package:flutter/material.dart';
import 'profil_bilgileri_formu.dart';
import 'package:provider/provider.dart';
import '../servisler/egzersiz_servisi.dart';
import '../servisler/kullanici_servisi.dart';
import '../ekranlar/giris_ekrani.dart';

class ProfilEkrani extends StatefulWidget {
  const ProfilEkrani({super.key});

  @override
  State<ProfilEkrani> createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Profil',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purple.shade400,
                      Colors.purple.shade700,
                    ],
                  ),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white.withOpacity(0.9),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildKullaniciBilgileri(),
                  const SizedBox(height: 24),
                  _buildHedefler(),
                  const SizedBox(height: 24),
                  _buildIstatistikler(),
                  const SizedBox(height: 24),
                  _buildAyarlar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKullaniciBilgileri() {
    final kullaniciServisi = context.watch<KullaniciServisi>();
    final kullanici = kullaniciServisi.kullanici;

    if (kullanici == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Profil bilgilerinizi doldurun',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _profilDuzenle(context),
                child: const Text('Profil Bilgilerini Doldur'),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(kullanici.ad),
              subtitle: const Text('Ad Soyad'),
              leading: const Icon(Icons.person),
            ),
            ListTile(
              title: Text('${kullanici.yas} yaş'),
              subtitle: const Text('Yaş'),
              leading: const Icon(Icons.cake),
            ),
            ListTile(
              title: Text('${kullanici.kilo} kg'),
              subtitle: const Text('Kilo'),
              leading: const Icon(Icons.monitor_weight),
            ),
            ListTile(
              title: Text('${kullanici.boy} cm'),
              subtitle: const Text('Boy'),
              leading: const Icon(Icons.height),
            ),
            ListTile(
              title: Text('${kullanici.gunlukKaloriHedefi} kcal'),
              subtitle: const Text('Günlük Kalori İhtiyacı'),
              leading: const Icon(Icons.local_fire_department),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHedefler() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hedefler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildHedefCubugu(
              'Günlük Kalori',
              0.7,
              '1400/2000 kcal',
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildHedefCubugu(
              'Haftalık Antrenman',
              0.8,
              '4/5 gün',
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildHedefCubugu(
              'Su Tüketimi',
              0.6,
              '1.5/2.5 L',
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHedefCubugu(
    String baslik,
    double ilerleme,
    String deger,
    Color renk,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(baslik),
            Text(
              deger,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: ilerleme,
          backgroundColor: renk.withOpacity(0.1),
          valueColor: AlwaysStoppedAnimation<Color>(renk),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildIstatistikler() {
    final egzersizServisi = context.watch<EgzersizServisi>();
    
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'İstatistikler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIstatistikKutusu(
                  'Toplam Antrenman',
                  '${egzersizServisi.aylikAntrenmanSayisi}',
                  Icons.fitness_center,
                  Colors.purple,
                ),
                _buildIstatistikKutusu(
                  'Toplam Süre',
                  '${egzersizServisi.aylikToplamSure} dk',
                  Icons.timer,
                  Colors.blue,
                ),
                _buildIstatistikKutusu(
                  'Yakılan Kalori',
                  '${egzersizServisi.aylikYakilanKalori}',
                  Icons.local_fire_department,
                  Colors.orange,
                ),
              ],
            ),
            if (egzersizServisi.antrenmanDevamEdiyor)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Antrenman devam ediyor...',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIstatistikKutusu(
    String baslik,
    String deger,
    IconData ikon,
    Color renk,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: renk.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(ikon, color: renk),
        ),
        const SizedBox(height: 8),
        Text(
          baslik,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          deger,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildAyarlar() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildAyarButonu(context, 'Profil Düzenle', Icons.edit, Colors.blue),
          _buildAyarButonu(context, 'Bildirimler', Icons.notifications, Colors.orange),
          _buildAyarButonu(context, 'Gizlilik', Icons.security, Colors.green),
          _buildAyarButonu(context, 'Çıkış Yap', Icons.exit_to_app, Colors.red),
        ],
      ),
    );
  }

  Widget _buildAyarButonu(BuildContext context, String baslik, IconData ikon, Color renk) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: renk.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(ikon, color: renk),
      ),
      title: Text(baslik),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        if (baslik == 'Profil Düzenle') {
          _profilDuzenle(context);
        } else if (baslik == 'Çıkış Yap') {
          _cikisYap(context);
        }
        // Diğer ayar işlemleri
      },
    );
  }
}

// Profil düzenleme butonuna basıldığında
void _profilDuzenle(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ProfilBilgileriFormu(),
    ),
  );
}

void _cikisYap(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Çıkış Yap'),
      content: const Text('Çıkış yapmak istediğinizden emin misiniz?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<KullaniciServisi>().cikisYap();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const GirisEkrani()),
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Çıkış Yap'),
        ),
      ],
    ),
  );
} 