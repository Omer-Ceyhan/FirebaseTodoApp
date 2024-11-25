// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emlak İlan Formu',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Satilik(), // Ana sayfa olarak Satilik sayfasını ekledim
      debugShowCheckedModeBanner: false,
    );
  }
}

// Satılık sayfası
class Satilik extends StatefulWidget {
  @override
  _SatilikState createState() => _SatilikState();
}

class _SatilikState extends State<Satilik> {
  int count = 0;

  // Controllers for TextFormField inputs
  final TextEditingController ilanAdiController = TextEditingController();
  final TextEditingController fiyatController = TextEditingController();
  final TextEditingController adresController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();

  // İlan verilerini tutmak için bir liste
  List<Map<String, dynamic>> ilanlar = [];

  // Dinamik olarak alacağımız veriler için değişkenler
  String ilanTuru = 'Satılık'; // Varsayılan olarak "Satılık" seçildi

  // void _addIlan() {
  //   if (_formKey.currentState!.validate()) {
  //     // Yeni ilanı listeye ekle
  //     setState(() {
  //       ilanlar.add({
  //         'ilanAdi': ilanAdiController.text,
  //         'fiyat': double.tryParse(fiyatController.text) ?? 0,
  //         'adres': adresController.text,
  //         'telefon': telefonController.text,
  //         'ilanTuru': ilanTuru,
  //       });
  //       // Form alanlarını temizle
  //       ilanAdiController.clear();
  //       fiyatController.clear();
  //       adresController.clear();
  //       telefonController.clear();
  //       ilanTuru = 'Satılık'; // Varsayılanı geri yükle
  //     });

  //     // Kullanıcıya bildirim göster
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('İlan başarıyla eklendi')),
  //     );
  //   }
  // }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    ilanAdiController.dispose();
    fiyatController.dispose();
    adresController.dispose();
    telefonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emlak İlanları'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('satilik').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshots) {
            if (snapshots.hasError) {
              return Center(
                child: Text('Hata'),
              );
            }
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            var data = snapshots.data!.docs;

            // final data1=data[0];
            // final data2=data1.data();
            // List deneme=[{"deneme1":"ahmet"},"string",["ahmet","pancar"]];
            // Map<String, dynamic> deneme = {
            //   "ilan adi": "deneme",
            //   "adres": "deneme adres",
            //   "telefon": "555555"
            // };
            // List<String> liste = ["ahmet", "mehmet", "ömer"];
            // print(liste[0]);
            // print(deneme["ilan adi"]);
            // print(deneme[0]["deneme1"]);
            count = int.parse(snapshots.data!.docs.last.id);
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'İlan Ekle',
                              style: TextStyle(color: Colors.black),
                            ),
                            content: Form(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: ilanAdiController,
                                    decoration:
                                        InputDecoration(labelText: 'İlan Adı'),
                                  ),
                                  TextFormField(
                                    controller: adresController,
                                    decoration:
                                        InputDecoration(labelText: 'Adres'),
                                  ),
                                  TextFormField(
                                    controller: telefonController,
                                    decoration:
                                        InputDecoration(labelText: 'Telefon'),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  Map<String, dynamic> ekle = {
                                    "Adres": adresController.text,
                                    "telefon": telefonController.text,
                                    "İlan Adi": ilanAdiController.text,
                                  };

                                  await FirebaseFirestore.instance
                                      .collection('satilik')
                                      .doc("${count + 1}")
                                      .set(ekle)
                                      .whenComplete(() {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Eklendi')),
                                    );

                                    Navigator.pop(context);
                                  });
                                },
                                child: Text(
                                  'Kaydet',
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('İptal'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'İlan Ekle',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(data[index]['Adres']),
                            subtitle:
                                Text(data[index]['telefon'] ?? "Telefon yok"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    // Güncelleme işlemi için bir form açılıyor
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        ilanAdiController.text =
                                            data[index]['İlan Adi'];
                                        adresController.text =
                                            data[index]['Adres'];
                                        telefonController.text =
                                            data[index]['telefon'];
                                        // print(data);
                                        return AlertDialog(
                                          title: Text('İlanı Güncelle'),
                                          content: Form(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller: ilanAdiController,
                                                  decoration: InputDecoration(
                                                      labelText: 'İlan Adı'),
                                                ),
                                                TextFormField(
                                                  controller: adresController,
                                                  decoration: InputDecoration(
                                                      labelText: 'Adres'),
                                                ),
                                                TextFormField(
                                                  controller: telefonController,
                                                  decoration: InputDecoration(
                                                      labelText: 'Telefon'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('satilik')
                                                    .doc(data[index].id)
                                                    .update({
                                                  "İlan Adi":
                                                      ilanAdiController.text,
                                                  "Adres": adresController.text,
                                                  "telefon":
                                                      telefonController.text,
                                                }).whenComplete(() {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'İlan güncellendi')),
                                                  );
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text('Güncelle'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('İptal'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('satilik')
                                        .doc(data[index].id)
                                        .delete()
                                        .whenComplete(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text('İlan silindi')),
                                      );
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_outward_outlined,
                                      color: Colors.deepPurple),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                IlanDetaySayfasi(
                                                    ilan: data[index].data())));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class IlanDetaySayfasi extends StatelessWidget {
  final Map<String, dynamic> ilan;

  IlanDetaySayfasi({
    required this.ilan,
  });

  final TextEditingController ilanAdiController = TextEditingController();
  final TextEditingController adresController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Varsayılan verileri TextFormField'lara yükleyelim
    ilanAdiController.text = ilan['İlan Adi'] ?? '';
    adresController.text = ilan['Adres'] ?? '';
    telefonController.text = ilan['telefon'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('İlan Detayı'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('İlan Adı: ${ilan['İlan Adi']}',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Adres: ${ilan['Adres']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Telefon: ${ilan['telefon']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            Text(ilan["deneme"])
          ],
        ),
      ),
    );
  }
}
