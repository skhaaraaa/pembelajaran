import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DaftarMateriPage extends StatefulWidget {
  final int mapelId;
  final int pertemuanKe;

  const DaftarMateriPage({
    super.key,
    required this.mapelId,
    required this.pertemuanKe,
  });

  @override
  State<DaftarMateriPage> createState() => _DaftarMateriPageState();
}

class _DaftarMateriPageState extends State<DaftarMateriPage> {
  List materiList = [];

  @override
  void initState() {
    super.initState();
    fetchMateri();
  }

  Future<void> fetchMateri() async {
    final url = Uri.parse("http:// 192.168.1.9/api/get_materi.php"); // Ganti IP
    final response = await http.post(url, body: {
      'mapel_id': widget.mapelId.toString(),
      'pertemuan': widget.pertemuanKe.toString(),
    });

    final data = jsonDecode(response.body);
    if (data['success']) {
      setState(() {
        materiList = data['materi'];
      });
    } else {
      print("Gagal ambil materi: ${data['message']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Materi Pertemuan ${widget.pertemuanKe}")),
      body: materiList.isEmpty
          ? const Center(child: Text("Belum ada materi."))
          : ListView.builder(
              itemCount: materiList.length,
              itemBuilder: (context, index) {
                final materi = materiList[index];
                return Card(
                  child: ListTile(
                    title: Text(materi['title']),
                    subtitle: Text(materi['description']),
                    trailing: IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: () {
                        // Tambahkan logika download materi jika perlu
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Fitur download belum tersedia")),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
