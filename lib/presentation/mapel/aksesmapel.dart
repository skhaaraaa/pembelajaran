import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pertemuan/daftarpertemuan.dart';

class AksesMapelPage extends StatefulWidget {
  final int siswaId;

  const AksesMapelPage({super.key, required this.siswaId});

  @override
  State<AksesMapelPage> createState() => _AksesMapelPageState();
}

class _AksesMapelPageState extends State<AksesMapelPage> {
  List _mapelEnrolled = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMapelEnrolled();
  }

  Future<void> fetchMapelEnrolled() async {
    final url = Uri.parse("http://192.168.1.9/api/get_enrolled_mapel.php"); // Ganti dengan IP backend kamu
    try {
      final response = await http.post(url, body: {
        'siswa_id': widget.siswaId.toString(),
      });

      final data = jsonDecode(response.body);
      if (data['success']) {
        setState(() {
          _mapelEnrolled = data['mapel'];
          _isLoading = false;
        });
      } else {
        showMessage("Gagal: ${data['message']}");
      }
    } catch (e) {
      showMessage("Gagal terhubung ke server.");
    }
  }

  void showMessage(String message) {
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mata Pelajaran Saya")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _mapelEnrolled.isEmpty
              ? const Center(child: Text("Belum mengikuti mata pelajaran."))
              : ListView.builder(
                  itemCount: _mapelEnrolled.length,
                  itemBuilder: (context, index) {
                    final mapel = _mapelEnrolled[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(mapel['nama_mapel']),
                        subtitle: Text(mapel['deskripsi'] ?? "-"),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DaftarPertemuanPage(
                                mapelId: int.parse(mapel['id']),
                                namaMapel: mapel['nama_mapel'],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
