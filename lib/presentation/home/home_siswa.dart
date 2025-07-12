import 'package:flutter/material.dart';
import '../login/login.dart';
import '../login/profile.dart';
import '../mapel/aksesmapel.dart';
import '../tugas/daftartugassiswa.dart';
import '../nilai/lihat.dart';
import '../../notifikasi.dart';

class HomeSiswa extends StatelessWidget {
  final int id;
  final String name;
  final String email;
  final String role;

  const HomeSiswa({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.role, required String password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Siswa - $name"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(
                    name: name,
                    email: email,
                    role: role,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text("Selamat Datang, $name!",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // Akses Mata Pelajaran
          Card(
            child: ListTile(
              leading: const Icon(Icons.book),
              title: const Text("Mata Pelajaran"),
              subtitle: const Text("Lihat daftar mata pelajaran Anda"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AksesMapelPage(siswaId: id),
                  ),
                );
              },
            ),
          ),

          // Lihat Tugas
          Card(
            child: ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text("Tugas"),
              subtitle: const Text("Lihat dan kerjakan tugas"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DaftarTugasSiswaPage(siswaId: id),
                  ),
                );
              },
            ),
          ),

          // Lihat Nilai
          Card(
            child: ListTile(
              leading: const Icon(Icons.grade),
              title: const Text("Nilai"),
              subtitle: const Text("Lihat nilai Anda"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LihatNilaiPage(siswaId: id),
                  ),
                );
              },
            ),
          ),

          // Notifikasi Tugas
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications_active),
              title: const Text("Notifikasi Tugas"),
              subtitle: const Text("Tugas mendekati deadline"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NotifikasiTugasPage(siswaId: id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
