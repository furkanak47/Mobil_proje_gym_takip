import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../servisler/yemek_servisi.dart';

class YemekAramaDelegate extends SearchDelegate<Yemek?> {
  @override
  String get searchFieldLabel => 'Yemek veya besin değeri ara';

  @override
  TextStyle get searchFieldStyle => const TextStyle(
    fontSize: 18,
    color: Colors.black87,
  );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _aramaSonuclari(context);

  @override
  Widget buildSuggestions(BuildContext context) => _aramaSonuclari(context);

  Widget _aramaSonuclari(BuildContext context) {
    final yemekServisi = context.read<YemekServisi>();
    final sonuclar = yemekServisi.yemekAra(query);

    if (sonuclar.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              query.isEmpty
                  ? 'Tüm yemekler listeleniyor'
                  : 'Yemek bulunamadı',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: sonuclar.length,
      itemBuilder: (context, index) {
        final yemek = sonuclar[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green[50],
              child: Text(
                '${yemek.kalori}',
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              yemek.ad,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${yemek.besinDegerleri}\n${yemek.birim}',
              style: const TextStyle(fontSize: 12),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: Colors.green,
              onPressed: () {
                yemekServisi.yemekEkle(yemek);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${yemek.ad} eklendi'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
} 