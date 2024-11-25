// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Öztaş Emlak İlanları',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AcilisSayfasi(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AcilisSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öztaş Emlak İlanları'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Emlak İlanı Seçin',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Satılık Kart
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  'Satılık İlanlar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Satılık emlak ilanlarını görmek için tıklayın.',
                  style: TextStyle(fontSize: 16),
                ),
                leading: Icon(Icons.house, size: 40),
                onTap: () {
                  // Satılık ilanlar sayfasına yönlendirme
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IlanListesiSayfasi(ilanTuru: 'Satılık'),
                    ),
                  );
                },
              ),
            ),
            // Kiralık Kart
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  'Kiralık İlanlar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Kiralık emlak ilanlarını görmek için tıklayın.',
                  style: TextStyle(fontSize: 16),
                ),
                leading: Icon(Icons.apartment, size: 40, color: Color(0xFFE10E0E)),
                onTap: () {
                  // Kiralık ilanlar sayfasına yönlendirme
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IlanListesiSayfasi(ilanTuru: 'Kiralık'),
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

class IlanListesiSayfasi extends StatelessWidget {
  final String ilanTuru;

  IlanListesiSayfasi({required this.ilanTuru});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$ilanTuru İlanları'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            '$ilanTuru ilanlarını görmektesiniz.',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
