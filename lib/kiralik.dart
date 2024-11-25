// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/acilis.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emlak İlan Formu',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Kiralik(),  // Ana sayfa olarak Kiralik sayfasını ekledim
      debugShowCheckedModeBanner: false,
    );
  }
}

// Kiralık sayfası
class Kiralik extends StatefulWidget {
  @override
  _KiralikState createState() => _KiralikState();
}

class _KiralikState extends State<Kiralik> {
  final _formKey = GlobalKey<FormState>();

  // İlan verilerini tutmak için bir liste
  List<Map<String, dynamic>> ilanlar = [];

  // Dinamik olarak alacağımız veriler için değişkenler


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emlak İlanları (Kiralık)'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('İlan Ekle'),
                      content: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(labelText: 'İlan Adı'),
                              onChanged: (value) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'İlan adı zorunludur';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Fiyat'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Fiyat zorunludur';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Adres'),
                              onChanged: (value) => {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Adres zorunludur';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Telefon'),
                              onChanged: (value) => {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Telefon zorunludur';
                                }
                                return null;
                              },
                            ),
                            
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {// Dialog'u kapat
                          },
                          child: Text('Kaydet'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Dialog'u kapat
                          },
                          child: Text('İptal'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('İlan Ekle'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: ilanlar.length,
                itemBuilder: (context, index) {
                  final ilan = ilanlar[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(ilan['ilanAdi'] ?? ''),
                      subtitle: Text('Fiyat: ${ilan['fiyat']} - Tür: ${ilan['ilanTuru']}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IlanDetaySayfasi(
                              ilan: ilan,
                            ),
                          ),
                        );
                      },
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

class IlanDetaySayfasi extends StatelessWidget {
  final Map<String, dynamic> ilan;

  IlanDetaySayfasi({required this.ilan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlan Detayı'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('İlan Adı: ${ilan['ilanAdi']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Fiyat: ${ilan['fiyat']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Adres: ${ilan['adres']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Telefon: ${ilan['telefon']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('İlan Türü: ${ilan['ilanTuru']}', style: TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AcilisSayfasi()),
                );
              },
              child: Text('Git'),
            ),
          ],
        ),
      ),
    );
  }
}
