// main.dart
import 'package:flutter/material.dart';
import 'package:patients/inputDNI.dart';
import 'dart:async'; 
import 'inputCode.dart';

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
    
    // Retrasa la navegación a la segunda vista después de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
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
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            const Text(
              'SISTEMA DE RECEPCIONES',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'images/golf.jpg',
              width: 200,
              height: 200,
            ),
          ],
          
        ),
      ),
    );
  }
}
