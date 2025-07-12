import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InputNilaiPage extends StatefulWidget {
  const InputNilaiPage({super.key});

  @override
  State<InputNilaiPage> createState() => _InputNilaiPageState();
}

class _InputNilaiPageState extends State<InputNilaiPage> {
  final _formKey = GlobalKey<FormState>();
  final _submissionIdController = TextEditingController();
  final _scoreController = TextEditingController();
  final _feedbackController = TextEditingController();

  Future<void> _submit() async {
    final url = Uri.parse("http://192.168.1.9/api/input_nilai.php"); // Ganti IP
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "submission_id": _submissionIdController.text,
        "score": _scoreController.text,
        "feedback": _feedbackController.text,
      }),
    );

    final data = jsonDecode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message'])),
    );

    if (data['success']) {
      _submissionIdController.clear();
      _scoreController.clear();
      _feedbackController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Input Nilai")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _submissionIdController,
                decoration: const InputDecoration(labelText: "ID Submit Tugas"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _scoreController,
                decoration: const InputDecoration(labelText: "Nilai"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _feedbackController,
                decoration: const InputDecoration(labelText: "Catatan / Feedback"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Simpan Nilai"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
