// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:patients/inputDNI.dart';

class WelcomeScreen extends StatelessWidget {
  final String nombre;

  const WelcomeScreen({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Check-in completed!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20), // Espacio entre el texto y el botón
            ElevatedButton(
              onPressed: () {
                // Navega a la siguiente pantalla (InputDNI)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => InputDNI()),
                );
              },
              
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
