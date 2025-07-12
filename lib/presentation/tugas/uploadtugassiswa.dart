// lib/tugas/upload_tugas_siswa.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadTugasSiswaPage extends StatefulWidget {
  final int tugasId;
  final int siswaId;

  const UploadTugasSiswaPage({super.key, required this.tugasId, required this.siswaId});

  @override
  State<UploadTugasSiswaPage> createState() => _UploadTugasSiswaPageState();
}

class _UploadTugasSiswaPageState extends State<UploadTugasSiswaPage> {
  File? _selectedFile;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _upload() async {
    if (_selectedFile == null) return;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://10.93.105.119/api/kumpul_tugas.php"),
    );

    request.fields['tugas_id'] = widget.tugasId.toString();
    request.fields['siswa_id'] = widget.siswaId.toString();

    request.files.add(await http.MultipartFile.fromPath('file', _selectedFile!.path));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final data = jsonDecode(responseBody);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Jawaban Tugas")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.attach_file),
              label: const Text("Pilih File"),
              onPressed: _pickFile,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _upload,
              child: const Text("Kirim Tugas"),
            ),
          ],
        ),
      ),
    );
  }
}
