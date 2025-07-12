// lib/pertemuan/daftar_pertemuan.dart
import 'package:flutter/material.dart';
import 'upload_materitugas.dart';

class DaftarPertemuanPage extends StatelessWidget {
  final int mapelId;
  final String namaMapel;

  const DaftarPertemuanPage({
    super.key,
    required this.mapelId,
    required this.namaMapel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pertemuan - $namaMapel')),
      body: ListView.builder(
        itemCount: 14,
        itemBuilder: (context, index) {
          final pertemuanKe = index + 1;
          return ListTile(
            title: Text("Pertemuan $pertemuanKe"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UploadMateriTugasPage(
                    mapelId: mapelId,
                    pertemuanKe: pertemuanKe,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
