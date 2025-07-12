import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pertemuan/daftarpertemuan.dart';

class DaftarMapelPage extends StatelessWidget {
  final String role; // 'guru' atau 'siswa'
  final int? userId; // opsional, bisa digunakan untuk filter atau logika

  const DaftarMapelPage({
    super.key,
    required this.role,
    this.userId,
  });

  Future<List<dynamic>> fetchMapel() async {
    final url = Uri.parse("http://192.168.1.9/api/getmapel.php"); // Ganti sesuai IP backend kamu
    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);

      if (data['success']) {
        return data['mapel'];
      } else {
        throw Exception(data['message'] ?? "Gagal mengambil mapel.");
      }
    } catch (e) {
      throw Exception("Terjadi error: $e");
    }
  }

  void _handleTap(BuildContext context, dynamic mapel) {
    if (role == 'guru') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DaftarPertemuanPage(
            mapelId: int.parse(mapel['id']),
            namaMapel: mapel['nama_mapel'],
          ),
        ),
      );
    } else {
      // Nanti bisa diarahkan ke halaman siswa melihat materi/tugas
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fitur belum tersedia untuk siswa")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Mata Pelajaran")),
      body: FutureBuilder<List<dynamic>>(
        future: fetchMapel(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
          }

          final mapelList = snapshot.data ?? [];

          if (mapelList.isEmpty) {
            return const Center(child: Text("Belum ada mata pelajaran."));
          }

          return ListView.builder(
            itemCount: mapelList.length,
            itemBuilder: (context, index) {
              final mapel = mapelList[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(mapel['nama_mapel']),
                  subtitle: Text(mapel['deskripsi'] ?? "-"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => _handleTap(context, mapel),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
