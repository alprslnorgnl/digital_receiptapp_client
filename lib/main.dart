import 'package:flutter/material.dart';
import 'auth/check_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Receipt App',
      home: CheckAuth(),
    );
  }
}
