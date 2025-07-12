import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final String role;

  const ProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/avatar.png'), // ganti jika pakai network
          ),
          const SizedBox(height: 20),
          Text(
            name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(email),
          Text("Role: $role"),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Fitur edit profil belum tersedia")),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text("Edit Profil"),
          ),
        ],
      ),
    );
  }
}
