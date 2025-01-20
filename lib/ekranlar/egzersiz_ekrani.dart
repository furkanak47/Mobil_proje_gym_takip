import 'package:flutter/material.dart';
import '../modeller/antrenman.dart';
import '../servisler/egzersiz_servisi.dart';
import 'package:provider/provider.dart';
import 'full_body_program_ekrani.dart';
import 'bolgesel_program_ekrani.dart';
import 'push_pull_legs_ekrani.dart';
import 'ev_programi_ekrani.dart';
import '../servisler/kullanici_servisi.dart';

class EgzersizEkrani extends StatefulWidget {
  const EgzersizEkrani({super.key});

  @override
  State<EgzersizEkrani> createState() => _EgzersizEkraniState();
}

class _EgzersizEkraniState extends State<EgzersizEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EgzersizServisi>(
        builder: (context, servis, child) {
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 180,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text(
                        'Antrenmanlar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.blue.shade800,
                              Colors.blue.shade500,
                              Colors.blue.shade300,
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -50,
                              top: -20,
                              child: Icon(
                                Icons.fitness_center,
                                size: 200,
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        if (servis.antrenmanDevamEdiyor) _AktifAntrenmanBilgisi(),
                        _programAciklamasi(
                          'Full Body Program',
                          'Tüm vücut kas gruplarını çalıştıran, haftada 3 gün yapılan etkili bir program. Yeni başlayanlar için idealdir.',
                          Colors.blue,
                        ),
                        _programAciklamasi(
                          'Bölgesel Program',
                          'Her gün farklı bir kas grubunu hedefleyen, detaylı bir program. Deneyimli sporcular için uygundur.',
                          Colors.purple,
                        ),
                        _programAciklamasi(
                          'Push/Pull/Legs',
                          'İtme, çekme ve bacak hareketlerini ayıran, haftada 3-6 gün yapılabilen esnek bir program.',
                          Colors.orange,
                        ),
                        _programAciklamasi(
                          'Ev Programı',
                          'Minimal ekipmanla evde yapılabilen, etkili vücut ağırlığı egzersizlerinden oluşan program.',
                          Colors.green,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Günlük İstatistikler',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _istatistikKutusu('Antrenman Sayısı', '3', Icons.fitness_center),
                                  _istatistikKutusu('Toplam Süre', '45 dk', Icons.timer),
                                  _istatistikKutusu('Yakılan Kalori', '320', Icons.local_fire_department),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 8.0,
                            children: [
                              _programKarti(
                                context,
                                'Full Body',
                                Icons.fitness_center,
                                const FullBodyProgramEkrani(),
                                [
                                  'Pazartesi: Tüm Vücut A',
                                  'Çarşamba: Tüm Vücut B',
                                  'Cuma: Tüm Vücut C',
                                ],
                              ),
                              _programKarti(
                                context,
                                'Bölgesel',
                                Icons.sports_gymnastics,
                                const BolgeselProgramEkrani(),
                                [
                                  'Pazartesi: Göğüs',
                                  'Salı: Sırt',
                                  'Çarşamba: Bacak',
                                  'Perşembe: Omuz',
                                  'Cuma: Kol',
                                ],
                              ),
                              _programKarti(
                                context,
                                'Push/Pull/Legs',
                                Icons.accessibility_new,
                                const PushPullLegsEkrani(),
                                [
                                  'Pazartesi: Push',
                                  'Salı: Pull',
                                  'Çarşamba: Legs',
                                ],
                              ),
                              _programKarti(
                                context,
                                'Evde Antrenman',
                                Icons.home_work,
                                const EvProgramiEkrani(),
                                [
                                  'Pazartesi: Üst Vücut',
                                  'Çarşamba: Alt Vücut',
                                  'Cuma: Kardiyo',
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Antrenman Geçmişi',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: servis.antrenmanGecmisi.length,
                          itemBuilder: (context, index) {
                            return _gecmisAntrenmanKarti(
                              context,
                              servis.antrenmanGecmisi[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const _HizliAntrenmanSayfasi(),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Hızlı Başlat'),
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _programKarti(BuildContext context, String baslik, IconData ikon, 
      Widget hedefSayfa, List<String> gunler) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => hedefSayfa),
        ),
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(ikon, color: Colors.blue, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  baslik,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gecmisAntrenmanKarti(BuildContext context, Antrenman antrenman) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: const Icon(Icons.fitness_center),
        ),
        title: Text(antrenman.baslik),
        subtitle: Text(
          '${antrenman.sure} • ${antrenman.zorluk}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Antrenman detaylarını göster
        },
      ),
    );
  }

  Widget _istatistikKutusu(String baslik, String deger, IconData ikon) {
    final kullanici = context.watch<KullaniciServisi>().kullanici;
    final hedefKalori = kullanici?.gunlukKaloriHedefi ?? 2000;
    final yakilan = context.watch<EgzersizServisi>().gunlukYakilanKalori;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(ikon, size: 32, color: Colors.blue),
          const SizedBox(height: 8),
          Text(baslik, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            deger,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          if (baslik == 'Yakılan Kalori')
            Text(
              '$yakilan / $hedefKalori kcal',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
        ],
      ),
    );
  }

  Widget _programAciklamasi(String baslik, String aciklama, Color renk) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: renk.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: renk.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            baslik,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: renk,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            aciklama,
            style: TextStyle(
              fontSize: 14,
              color: renk.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _AktifAntrenmanBilgisi extends StatelessWidget {
  const _AktifAntrenmanBilgisi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final servis = context.watch<EgzersizServisi>();
    final baslangic = servis.baslangicZamani;
    if (baslangic == null) return const SizedBox.shrink();

    final gecenSure = DateTime.now().difference(baslangic);
    final tahminiKalori = (gecenSure.inMinutes * 7).toString();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer, color: Colors.green.shade700),
              const SizedBox(width: 8),
              Text(
                'Antrenman sürüyor: ${gecenSure.inMinutes} dakika',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Yakılan Kalori: $tahminiKalori',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              
              await servis.antrenmanBitir(yakilanKalori: int.parse(tahminiKalori));
              
              if (context.mounted) {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('Antrenman tamamlandı! $tahminiKalori kalori yakıldı'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            icon: const Icon(Icons.stop_circle_outlined),
            label: const Text('Antrenmanı Bitir'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HizliAntrenmanSayfasi extends StatelessWidget {
  const _HizliAntrenmanSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Hızlı Antrenman Seç',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _antrenmanButonu(
            context,
            '15 Dakika Express',
            Icons.timer_outlined,
            15,
            150,
          ),
          _antrenmanButonu(
            context,
            '30 Dakika Tam Vücut',
            Icons.fitness_center,
            30,
            300,
          ),
          _antrenmanButonu(
            context,
            '20 Dakika HIIT',
            Icons.local_fire_department,
            20,
            250,
          ),
        ],
      ),
    );
  }

  Widget _antrenmanButonu(BuildContext context, String baslik, IconData ikon, int sure, int kalori) {
    return ListTile(
      leading: Icon(ikon),
      title: Text(baslik),
      subtitle: Text('Yakılan Kalori: ~$kalori kcal'),
      onTap: () {
        context.read<EgzersizServisi>().antrenmanBaslat(
          Antrenman(
            baslik: baslik,
            sure: '$sure dk',
            zorluk: 'Orta',
            hedef: 'Kondisyon',
            yakilanKalori: kalori,
            hareketler: [],
          ),
        );
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$baslik başlatıldı!'),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
}
