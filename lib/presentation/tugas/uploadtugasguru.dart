// lib/tugas/upload_tugas.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UploadTugasPage extends StatefulWidget {
  final int guruId;

  const UploadTugasPage({super.key, required this.guruId});

  @override
  State<UploadTugasPage> createState() => _UploadTugasPageState();
}

class _UploadTugasPageState extends State<UploadTugasPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _mapelIdController = TextEditingController();
  final _pertemuanController = TextEditingController();
  final _tenggatController = TextEditingController();

  Future<void> _submit() async {
    final url = Uri.parse("http:// 10.93.105.119/api/upload_tugas.php"); // Ganti IP kamu
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "judul": _judulController.text,
        "deskripsi": _deskripsiController.text,
        "mapel_id": _mapelIdController.text,
        "pertemuan": _pertemuanController.text,
        "tenggat": _tenggatController.text,
        "uploaded_by": widget.guruId,
      }),
    );

    final data = jsonDecode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Tugas")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _mapelIdController, decoration: const InputDecoration(labelText: "Mapel ID")),
              TextFormField(controller: _judulController, decoration: const InputDecoration(labelText: "Judul")),
              TextFormField(controller: _deskripsiController, decoration: const InputDecoration(labelText: "Deskripsi")),
              TextFormField(controller: _pertemuanController, decoration: const InputDecoration(labelText: "Pertemuan")),
              TextFormField(controller: _tenggatController, decoration: const InputDecoration(labelText: "Tenggat (YYYY-MM-DD)")),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text("Upload Tugas"))
            ],
          ),
        ),
      ),
    );
  }
}
