// lib/pertemuan/upload_materitugas.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UploadMateriTugasPage extends StatefulWidget {
  final int mapelId;
  final int pertemuanKe;

  const UploadMateriTugasPage({
    super.key,
    required this.mapelId,
    required this.pertemuanKe,
  });

  @override
  State<UploadMateriTugasPage> createState() => _UploadMateriTugasPageState();
}

class _UploadMateriTugasPageState extends State<UploadMateriTugasPage> {
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();

  Future<void> _submitMateri() async {
    final url = Uri.parse("http://192.168.1.xx/api/upload_materi.php"); // ganti IP
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "mapel_id": widget.mapelId,
        "pertemuan": widget.pertemuanKe,
        "judul": _judulController.text,
        "deskripsi": _deskripsiController.text,
      }),
    );

    final data = jsonDecode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message'])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Materi - Pertemuan ${widget.pertemuanKe}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _judulController,
              decoration: const InputDecoration(labelText: "Judul Materi"),
            ),
            TextFormField(
              controller: _deskripsiController,
              decoration: const InputDecoration(labelText: "Deskripsi Materi"),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitMateri,
              child: const Text("Simpan Materi"),
            ),
          ],
        ),
      ),
    );
  }
}
