// lib/tugas/lihat_tugas.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'uploadtugassiswa.dart';

class DaftarTugasSiswaPage extends StatelessWidget {
  final int siswaId;

  const DaftarTugasSiswaPage({super.key, required this.siswaId});

  Future<List<dynamic>> fetchTugas() async {
    final response = await http.get(Uri.parse("http:// 10.93.105.119/api/get_tugas.php"));
    final data = jsonDecode(response.body);
    return data['tugas'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Tugas")),
      body: FutureBuilder<List<dynamic>>(
        future: fetchTugas(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final tugasList = snapshot.data!;
          return ListView.builder(
            itemCount: tugasList.length,
            itemBuilder: (context, index) {
              final tugas = tugasList[index];
              return ListTile(
                title: Text(tugas['judul']),
                subtitle: Text("Mapel ID: ${tugas['mapel_id']} | Pertemuan: ${tugas['pertemuan']}"),
                trailing: ElevatedButton(
                  child: const Text("Kumpul"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => UploadTugasSiswaPage(
                        tugasId: int.parse(tugas['id']),
                        siswaId: siswaId,
                      ),
                    ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
