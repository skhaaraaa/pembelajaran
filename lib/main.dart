import 'package:flutter/material.dart';
import 'presentation/login/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'classroom app',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const LoginPage()
 
    );
  }
}

      
