
import 'package:flutter/material.dart';
import 'lectura_screen.dart';

void main() {
  runApp(const SantaBibliaApp());
}

class SantaBibliaApp extends StatelessWidget {
  const SantaBibliaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Santa Biblia Cantera Jeyron',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF9A762F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9A762F),
        ),
        useMaterial3: true,
      ),
      home: const LecturaScreen(),
    );
  }
}
