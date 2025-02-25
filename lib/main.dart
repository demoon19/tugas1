import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(InspiraNoteApp());
}

class InspiraNoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: InspiraNoteHome(),
    );
  }
}

class InspiraNoteHome extends StatefulWidget {
  @override
  _InspiraNoteHomeState createState() => _InspiraNoteHomeState();
}

class _InspiraNoteHomeState extends State<InspiraNoteHome> {
  final _noteController = TextEditingController();
  String _savedNote = "";
  List<String> quotes = [
    "Jangan takut gagal, karena kegagalan adalah awal dari keberhasilan.",
    "Sukses dimulai dengan langkah pertama.",
    "Setiap hari adalah kesempatan baru untuk belajar.",
    "Kerja keras mengalahkan bakat ketika bakat tidak bekerja keras."
  ];
  String _currentQuote = "";

  @override
  void initState() {
    super.initState();
    _generateQuote();
  }

  void _generateQuote() {
    setState(() {
      _currentQuote = quotes[Random().nextInt(quotes.length)];
    });
  }

  void _saveNote() {
    setState(() {
      _savedNote = _noteController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Catatan disimpan!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text("InspiraNote", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: _generateQuote,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://picsum.photos/300/200',
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return Text("Gagal memuat gambar");
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _currentQuote,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                labelText: 'Tulis Catatanmu',
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Simpan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _savedNote.isNotEmpty ? "Catatan: $_savedNote" : "Belum ada catatan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
