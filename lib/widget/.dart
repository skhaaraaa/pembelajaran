import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> panggilAPI() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/api/halo'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("Pesan dari API: ${data['message']}");
    } else {
      print("Gagal memanggil API");
    }
  }

  @override
  Widget build(BuildContext context) {
    panggilAPI(); // bisa juga dipanggil dari button

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter + Flask')),
        body: const Center(child: Text('Coba lihat terminal!')),
      ),
    );
  }
}

