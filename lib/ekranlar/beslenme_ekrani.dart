import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../servisler/yemek_servisi.dart';
import '../ekranlar/yemek_arama_delegate.dart';
import '../servisler/kullanici_servisi.dart';

class BeslenmeEkrani extends StatelessWidget {
  const BeslenmeEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => YemekServisi(),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Beslenme Takibi'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: YemekAramaDelegate(),
                  );
                },
              ),
            ],
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            bottom: TabBar(
              indicatorColor: Colors.green,
              labelColor: Colors.green[700],
              unselectedLabelColor: Colors.grey[600],
              tabs: const [
                Tab(
                  icon: Icon(Icons.breakfast_dining),
                  text: 'Kahvaltı',
                ),
                Tab(
                  icon: Icon(Icons.lunch_dining),
                  text: 'Ana Yemek',
                ),
                Tab(
                  icon: Icon(Icons.restaurant),
                  text: 'Ara Öğün',
                ),
                Tab(
                  icon: Icon(Icons.local_drink),
                  text: 'İçecek',
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade50, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Consumer<KullaniciServisi>(
                      builder: (context, servis, child) => _beslenmeHedefKarti(
                        'Günlük Hedef',
                        '${servis.hedefKalori} kcal',
                        Icons.flag,
                        Colors.blue,
                      ),
                    ),
                    Consumer<YemekServisi>(
                      builder: (context, servis, child) => _beslenmeHedefKarti(
                        'Alınan',
                        '${servis.toplamKalori} kcal',
                        Icons.local_fire_department,
                        Colors.orange,
                      ),
                    ),
                    Consumer2<KullaniciServisi, YemekServisi>(
                      builder: (context, kullaniciServisi, yemekServisi, child) {
                        final kalan = kullaniciServisi.hedefKalori - yemekServisi.toplamKalori;
                        return _beslenmeHedefKarti(
                          'Kalan',
                          '$kalan kcal',
                          Icons.battery_charging_full,
                          kalan < 0 ? Colors.red : Colors.green,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _yemekListesi('Kahvaltılıklar'),
                    _yemekListesi('Ana Yemekler'),
                    _yemekListesi('Ara Öğünler'),
                    _yemekListesi('İçecekler'),
                  ],
                ),
              ),
              _sepetOzeti(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _beslenmeHedefKarti(String baslik, String deger, IconData ikon, Color renk) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: renk.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(ikon, color: renk, size: 24),
          const SizedBox(height: 4),
          Text(
            baslik,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          Text(
            deger,
            style: TextStyle(
              color: renk,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _yemekListesi(String kategori) {
    return Consumer<YemekServisi>(
      builder: (context, servis, child) {
        final yemekler = servis.kategoriler[kategori] ?? [];
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: yemekler.length,
          itemBuilder: (context, index) {
            final yemek = yemekler[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: CircleAvatar(
                  backgroundColor: Colors.green[50],
                  child: Icon(
                    Icons.restaurant_menu,
                    color: Colors.green[700],
                  ),
                ),
                title: Text(
                  yemek.ad,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(yemek.besinDegerleri),
                    Text(
                      '${yemek.kalori} kcal / ${yemek.birim}',
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.green[700],
                    size: 32,
                  ),
                  onPressed: () => servis.yemekEkle(yemek),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _sepetOzeti() {
    return Consumer<YemekServisi>(
      builder: (context, servis, child) {
        if (servis.secilenYemekler.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Henüz yemek seçilmedi',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Günlük Toplam',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${servis.toplamKalori} kcal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: servis.secilenYemekler.length,
                  itemBuilder: (context, index) {
                    final yemek = servis.secilenYemekler[index];
                    return ListTile(
                      dense: true,
                      leading: Icon(Icons.check_circle, color: Colors.green[300]),
                      title: Text(yemek.ad),
                      subtitle: Text('${yemek.kalori} kcal'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                        onPressed: () => servis.yemekCikar(yemek),
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  foregroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 40),
                ),
                onPressed: () => servis.sepetiTemizle(),
                icon: const Icon(Icons.delete_outline),
                label: const Text('Sepeti Temizle'),
              ),
            ],
          ),
        );
      },
    );
  }
} 