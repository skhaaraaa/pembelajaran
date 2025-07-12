import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class UploadMateriPage extends StatefulWidget {
  final int mapelId;
  final int pertemuanKe;
  final int guruId;

  const UploadMateriPage({
    super.key,
    required this.mapelId,
    required this.pertemuanKe,
    required this.guruId,
  });

  @override
  State<UploadMateriPage> createState() => _UploadMateriPageState();
}

class _UploadMateriPageState extends State<UploadMateriPage> {
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  File? _file;
  String? _fileName;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    }
  }

  Future<void> _uploadMateri() async {
    if (_file == null || _judulController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua data dan pilih file")),
      );
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http:// 10.93.105.119/api/upload_materi.php"), // Ganti IP sesuai lokalmu
    );

    request.fields['mapel_id'] = widget.mapelId.toString();
    request.fields['pertemuan'] = widget.pertemuanKe.toString();
    request.fields['guru_id'] = widget.guruId.toString();
    request.fields['judul'] = _judulController.text;
    request.fields['deskripsi'] = _deskripsiController.text;

    request.files.add(await http.MultipartFile.fromPath('file', _file!.path));

    final response = await request.send();
    final respStr = await response.stream.bytesToString();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(respStr)),
    );

    // Kosongkan form
    setState(() {
      _judulController.clear();
      _deskripsiController.clear();
      _file = null;
      _fileName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Materi")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _judulController,
              decoration: const InputDecoration(labelText: 'Judul Materi'),
            ),
            TextField(
              controller: _deskripsiController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Deskripsi Materi'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: const Icon(Icons.attach_file),
              label: const Text("Pilih File Materi"),
            ),
            if (_fileName != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("File: $_fileName"),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadMateri,
              child: const Text("Upload Sekarang"),
            ),
          ],
        ),
      ),
    );
  }
}
