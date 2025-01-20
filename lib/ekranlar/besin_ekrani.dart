import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../veriler/besinler.dart';
import '../servisler/besin_servisi.dart';

class BesinEkrani extends StatefulWidget {
  const BesinEkrani({super.key});

  @override
  State<BesinEkrani> createState() => _BesinEkraniState();
}

class _BesinEkraniState extends State<BesinEkrani> {
  @override
  Widget build(BuildContext context) {
    final besinServisi = context.watch<BesinServisi>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Beslenme Takibi',
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
                      Colors.orange.shade400,
                      Colors.orange.shade700,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.restaurant_menu,
                    size: 80,
                    color: Colors.white.withOpacity(0.3),
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
                  Text('Toplam Kalori: ${besinServisi.toplamKalori}'),
                  _buildMakroOzeti(context),
                  const SizedBox(height: 24),
                  _buildOgunListesi(),
                  const SizedBox(height: 24),
                  _buildBesinOnerileri(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMakroOzeti(BuildContext context) {
    final besinServisi = context.watch<BesinServisi>();

    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Günlük Makro Özeti',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMakroKutusu(
                  'Kalori',
                  '${besinServisi.toplamKalori}',
                  'kcal',
                  Colors.orange,
                ),
                _buildMakroKutusu(
                  'Protein',
                  '${besinServisi.toplamProtein.toStringAsFixed(1)}',
                  'g',
                  Colors.red,
                ),
                _buildMakroKutusu(
                  'Karbonhidrat',
                  '${besinServisi.toplamKarbonhidrat.toStringAsFixed(1)}',
                  'g',
                  Colors.blue,
                ),
                _buildMakroKutusu(
                  'Yağ',
                  '${besinServisi.toplamYag.toStringAsFixed(1)}',
                  'g',
                  Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMakroKutusu(
      String baslik, String deger, String birim, Color renk) {
    return Column(
      children: [
        Text(
          baslik,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          deger,
          style: TextStyle(
            color: renk,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          birim,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildOgunListesi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Öğünler',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildOgunKarti(
          'Kahvaltı',
          '420 kcal',
          Icons.wb_sunny,
          Colors.amber,
        ),
        _buildOgunKarti(
          'Öğle Yemeği',
          '650 kcal',
          Icons.sunny,
          Colors.orange,
        ),
        _buildOgunKarti(
          'Akşam Yemeği',
          '580 kcal',
          Icons.nights_stay,
          Colors.indigo,
        ),
        _buildOgunKarti(
          'Ara Öğünler',
          '200 kcal',
          Icons.access_time,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildOgunKarti(
      String baslik, String kalori, IconData ikon, Color renk) {
    return Consumer<BesinServisi>(
      builder: (context, besinServisi, child) {
        final ogunKalorisi = besinServisi.ogunKalorisi(baslik);
        final makrolar = besinServisi.ogunMakrolari(baslik);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: renk.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(ikon, color: renk),
                ),
                title: Text(baslik),
                subtitle: Text('$ogunKalorisi kcal'),
                trailing: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _oguneBesinEkle(context, baslik),
                ),
              ),
              if (ogunKalorisi > 0)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('P: ${makrolar['protein']?.toStringAsFixed(1)}g'),
                      Text(
                          'K: ${makrolar['karbonhidrat']?.toStringAsFixed(1)}g'),
                      Text('Y: ${makrolar['yağ']?.toStringAsFixed(1)}g'),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _oguneBesinEkle(BuildContext context, String ogunAdi) {
    final besinServisi = context.read<BesinServisi>();
    List<Besin> besinListesi;

    switch (ogunAdi) {
      case 'Kahvaltı':
        besinListesi = kahvaltiliklar;
        break;
      case 'Öğle Yemeği':
      case 'Akşam Yemeği':
        besinListesi = anaYemekler;
        break;
      case 'Ara Öğünler':
        besinListesi = atistirmaliklar;
        break;
      default:
        besinListesi = [];
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$ogunAdi için Besinler',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.shopping_cart),
                  label: Text(
                      '${besinServisi.getOgunBesinleri(ogunAdi).length} besin'),
                  onPressed: () => _sepetGoster(context, ogunAdi),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: besinListesi.length,
                itemBuilder: (context, index) {
                  final besin = besinListesi[index];
                  return Card(
                    child: ListTile(
                      title: Text(besin.ad),
                      subtitle: Text(
                        '${besin.miktar} • ${besin.kalori} kcal\n'
                        'P: ${besin.makrolar['protein']}g  K: ${besin.makrolar['karbonhidrat']}g  Y: ${besin.makrolar['yağ']}g',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          besinServisi.besinEkle(ogunAdi, besin);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${besin.ad} eklendi'),
                              action: SnackBarAction(
                                label: 'Geri Al',
                                onPressed: () =>
                                    besinServisi.besinCikar(ogunAdi, besin),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBesinOnerileri() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sağlıklı Besin Önerileri',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildBesinOnerisiKarti(
                'Protein Kaynakları',
                'Tavuk, balık, yumurta...',
                Icons.egg,
                Colors.brown,
              ),
              _buildBesinOnerisiKarti(
                'Kompleks Karbonhidratlar',
                'Yulaf, kinoa, tam tahıllar...',
                Icons.grain,
                Colors.amber,
              ),
              _buildBesinOnerisiKarti(
                'Sağlıklı Yağlar',
                'Avokado, zeytinyağı, kuruyemişler...',
                Icons.spa,
                Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBesinOnerisiKarti(
    String baslik,
    String aciklama,
    IconData ikon,
    Color renk,
  ) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                renk.withOpacity(0.1),
                renk.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: renk.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(ikon, color: renk),
              ),
              const SizedBox(height: 12),
              Text(
                baslik,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                aciklama,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sepetGoster(BuildContext context, String ogunAdi) {
    final besinServisi = context.read<BesinServisi>();
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$ogunAdi Sepeti',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: besinServisi.getOgunBesinleri(ogunAdi).length,
                itemBuilder: (context, index) {
                  final besin = besinServisi.getOgunBesinleri(ogunAdi)[index];
                  return ListTile(
                    title: Text(besin.ad),
                    subtitle: Text('${besin.kalori} kcal'),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => besinServisi.besinCikar(ogunAdi, besin),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
