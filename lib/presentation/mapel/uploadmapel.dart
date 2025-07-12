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
  final _judulMateriController = TextEditingController();
  final _judulTugasController = TextEditingController();
  final _deskripsiTugasController = TextEditingController();
  final _tenggatController = TextEditingController();

  Future<void> _uploadMateri() async {
    final url = Uri.parse("http://192.168.1.9/api/upload_materi.php");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'mapel_id': widget.mapelId,
        'pertemuan': widget.pertemuanKe,
        'judul': _judulMateriController.text,
      }),
    );

    final data = jsonDecode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message'] ?? 'Gagal upload materi')),
    );
  }

  Future<void> _uploadTugas() async {
    final url = Uri.parse("http://10.93.105.119/api/upload_tugas.php");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'mapel_id': widget.mapelId,
        'pertemuan': widget.pertemuanKe,
        'judul': _judulTugasController.text,
        'deskripsi': _deskripsiTugasController.text,
        'tenggat': _tenggatController.text,
      }),
    );

    final data = jsonDecode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message'] ?? 'Gagal upload tugas')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pertemuan ${widget.pertemuanKe}")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Upload Materi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _judulMateriController,
              decoration: const InputDecoration(labelText: 'Judul Materi'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _uploadMateri,
              child: const Text("Upload Materi"),
            ),
            const Divider(height: 40),
            const Text("Upload Tugas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _judulTugasController,
              decoration: const InputDecoration(labelText: 'Judul Tugas'),
            ),
            TextField(
              controller: _deskripsiTugasController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
            TextField(
              controller: _tenggatController,
              decoration: const InputDecoration(labelText: 'Tenggat (YYYY-MM-DD)'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _uploadTugas,
              child: const Text("Upload Tugas"),
            ),
          ],
        ),
      ),
    );
  }
}
