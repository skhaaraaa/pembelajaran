import 'package:flutter/material.dart';
import '../login/login.dart';
import '../login/profile.dart';
import '../mapel/daftarmapel.dart';
import '../tugas/uploadtugasguru.dart';
import '../nilai/input.dart';

class HomeGuru extends StatelessWidget {
  final int id;
  final String name;
  final String email;
  final String role;

  const HomeGuru({
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
        title: Text('Guru - $name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(name: name, email: email, role: role),
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          _menuCard(
            context,
            icon: Icons.class_,
            title: "Kelola Mapel",
            subtitle: "Upload & Lihat Mapel",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DaftarMapelPage(role: 'guru', userId: id)));
            },
          ),
          _menuCard(
            context,
            icon: Icons.upload_file,
            title: "Upload Tugas",
            subtitle: "Tambahkan tugas ke mapel",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => UploadTugasPage(guruId: id)));
            },
          ),
          _menuCard(
            context,
            icon: Icons.grade,
            title: "Input Nilai",
            subtitle: "Nilai siswa per tugas",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const InputNilaiPage()));
            },
          ),
        ],
      ),
    );
  }

  Widget _menuCard(BuildContext context,
      {required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
