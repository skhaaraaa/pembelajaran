import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LihatNilaiPage extends StatelessWidget {
  final int siswaId;

  const LihatNilaiPage({super.key, required this.siswaId});

  Future<List<dynamic>> fetchNilai() async {
    final response = await http.get(Uri.parse("http:// 10.93.105.119/api/lihat_nilai.php?siswa_id=$siswaId"));
    final data = jsonDecode(response.body);
    return data['nilai'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nilai Saya")),
      body: FutureBuilder<List<dynamic>>(
        future: fetchNilai(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada nilai."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final nilai = snapshot.data![index];
              return ListTile(
                title: Text("Tugas: ${nilai['judul']}"),
                subtitle: Text("Nilai: ${nilai['score']}\nFeedback: ${nilai['feedback']}"),
              );
            },
          );
        },
      ),
    );
  }
}
