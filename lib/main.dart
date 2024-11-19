// main.dart
import 'package:flutter/material.dart';
import 'package:patients/inputDNI.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrimeraVista(),
    );
  }
}

class PrimeraVista extends StatefulWidget {
  const PrimeraVista({super.key});

  @override
  _PrimeraVistaState createState() => _PrimeraVistaState();
}

class _PrimeraVistaState extends State<PrimeraVista> {
  @override
  void initState() {
    super.initState();

    // Navega inmediatamente a la segunda vista sin esperar
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InputDNI()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),  // Indicador de carga mientras se navega
    );
  }
}
