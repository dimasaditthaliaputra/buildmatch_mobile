import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BuildMatch')),
      body: const Center(
        child: Text(
          'Selamat datang di BuildMatch! 🎉',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
