import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../servisler/kullanici_servisi.dart';
import 'ana_ekran.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilBilgileriFormu extends StatefulWidget {
  const ProfilBilgileriFormu({super.key});

  @override
  State<ProfilBilgileriFormu> createState() => _ProfilBilgileriFormuState();
}

class _ProfilBilgileriFormuState extends State<ProfilBilgileriFormu> {
  final _formKey = GlobalKey<FormState>();
  final _adController = TextEditingController();
  final _emailController = TextEditingController();
  final _boyController = TextEditingController();
  final _kiloController = TextEditingController();
  final _yasController = TextEditingController();
  String _cinsiyet = 'Erkek';
  String _hedef = 'Kilo Vermek';
  double _aktiviteSeviyesi = 1.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Düzenle')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Kişisel Bilgiler',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Size özel bir program hazırlayabilmemiz için lütfen bilgilerinizi girin',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _adController,
                    decoration: const InputDecoration(labelText: 'Ad Soyad'),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'E-posta'),
                  ),
                  _buildTextField(
                    controller: _boyController,
                    label: 'Boy (cm)',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Boy gerekli';
                      final boy = int.tryParse(value);
                      if (boy == null || boy < 100 || boy > 250) {
                        return 'Geçerli bir boy girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _kiloController,
                    label: 'Kilo (kg)',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Kilo gerekli';
                      final kilo = int.tryParse(value);
                      if (kilo == null || kilo < 30 || kilo > 300) {
                        return 'Geçerli bir kilo girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _yasController,
                    label: 'Yaş',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Yaş gerekli';
                      final yas = int.tryParse(value);
                      if (yas == null || yas < 12 || yas > 100) {
                        return 'Geçerli bir yaş girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cinsiyet',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: const Text('Erkek'),
                                  value: 'Erkek',
                                  groupValue: _cinsiyet,
                                  onChanged: (value) {
                                    setState(() => _cinsiyet = value!);
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  title: const Text('Kadın'),
                                  value: 'Kadın',
                                  groupValue: _cinsiyet,
                                  onChanged: (value) {
                                    setState(() => _cinsiyet = value!);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hedefiniz',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: _hedef,
                            items: [
                              'Kilo Vermek',
                              'Kilo Almak',
                              'Kas Kazanmak',
                              'Fit Kalmak',
                            ].map((hedef) {
                              return DropdownMenuItem(
                                value: hedef,
                                child: Text(hedef),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() => _hedef = value!);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Aktivite Seviyeniz',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Slider(
                            value: _aktiviteSeviyesi,
                            min: 1.2,
                            max: 1.9,
                            divisions: 4,
                            label: _aktiviteSeviyesiAciklama(),
                            onChanged: (value) {
                              setState(() => _aktiviteSeviyesi = value);
                            },
                          ),
                          Text(
                            _aktiviteSeviyesiDetay(),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _kaydet,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Kaydet',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }

  String _aktiviteSeviyesiAciklama() {
    if (_aktiviteSeviyesi <= 1.2) return 'Hareketsiz';
    if (_aktiviteSeviyesi <= 1.375) return 'Az Hareketli';
    if (_aktiviteSeviyesi <= 1.55) return 'Orta Hareketli';
    if (_aktiviteSeviyesi <= 1.725) return 'Çok Hareketli';
    return 'Aşırı Hareketli';
  }

  String _aktiviteSeviyesiDetay() {
    if (_aktiviteSeviyesi <= 1.2) {
      return 'Masa başı iş, spor yok';
    }
    if (_aktiviteSeviyesi <= 1.375) {
      return 'Hafif aktivite, haftada 1-2 gün spor';
    }
    if (_aktiviteSeviyesi <= 1.55) {
      return 'Orta aktivite, haftada 3-4 gün spor';
    }
    if (_aktiviteSeviyesi <= 1.725) {
      return 'Yüksek aktivite, haftada 5-6 gün spor';
    }
    return 'Profesyonel sporcu seviyesi';
  }

  Future<void> _kaydet() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('kullaniciAdi', _adController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('boy', _boyController.text);
      await prefs.setString('kilo', _kiloController.text);
      await prefs.setString('yas', _yasController.text);

      final bilgiler = {
        'boy': int.parse(_boyController.text),
        'kilo': int.parse(_kiloController.text),
        'yas': int.parse(_yasController.text),
        'cinsiyet': _cinsiyet,
        'hedef': _hedef,
        'aktiviteSeviyesi': _aktiviteSeviyesi,
      };

      final kullaniciServisi = context.read<KullaniciServisi>();
      kullaniciServisi.profilBilgileriniGuncelle(bilgiler);

      // Hedef kalori hesaplama
      final bmr = kullaniciServisi.gunlukKaloriIhtiyaciHesapla();
      int hedefKalori = bmr;

      // Hedefe göre kalori ayarlama
      switch (_hedef) {
        case 'Kilo Vermek':
          hedefKalori = (bmr * 0.8).round(); // %20 kalori açığı
          break;
        case 'Kilo Almak':
          hedefKalori = (bmr * 1.2).round(); // %20 kalori fazlası
          break;
        case 'Kas Kazanmak':
          hedefKalori = (bmr * 1.1).round(); // %10 kalori fazlası + yüksek protein
          break;
        case 'Fit Kalmak':
          // BMR değeri aynen kalır
          break;
      }

      kullaniciServisi.hedefKaloriGuncelle(hedefKalori);

      // Hesaplanan kaloriyi göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Günlük hedef kaloriniz: $hedefKalori kcal olarak belirlendi.',
            style: const TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AnaEkran()),
      );
    }
  }
} 