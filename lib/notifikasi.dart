import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotifikasiTugasPage extends StatefulWidget {
  final int siswaId;

  const NotifikasiTugasPage({super.key, required this.siswaId});

  @override
  State<NotifikasiTugasPage> createState() => _NotifikasiTugasPageState();
}

class _NotifikasiTugasPageState extends State<NotifikasiTugasPage> {
  List _tugasDeadline = [];

  @override
  void initState() {
    super.initState();
    fetchTugasDeadline();
  }

  Future<void> fetchTugasDeadline() async {
    final url = Uri.parse("http://192.168.1.xx/api/get_tugas_deadline.php"); // ganti IP lokalmu
    final response = await http.post(url, body: {
      'siswa_id': widget.siswaId.toString(),
    });

    final data = jsonDecode(response.body);
    if (data['success']) {
      setState(() {
        _tugasDeadline = data['tugas'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tugas Mendekati Deadline")),
      body: _tugasDeadline.isEmpty
          ? const Center(child: Text("Tidak ada tugas mendekati tenggat."))
          : ListView.builder(
              itemCount: _tugasDeadline.length,
              itemBuilder: (context, index) {
                final tugas = _tugasDeadline[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(tugas['judul']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mapel: ${tugas['nama_mapel']}"),
                        Text("Tenggat: ${tugas['tenggat']}"),
                      ],
                    ),
                    trailing: const Icon(Icons.warning, color: Colors.red),
                  ),
                );
              },
            ),
    );
  }
}
