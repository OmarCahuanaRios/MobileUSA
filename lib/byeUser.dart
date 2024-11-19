// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:patients/inputDNI.dart';
import 'package:patients/qrscreen.dart';

class ByeUserScreen extends StatelessWidget {
  const ByeUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Unable to check in',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20), // Espacio entre el texto y los botones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón de "Back"
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Volver a la pantalla anterior
                  },
                  
                  child: const Text('Back'),
                ),
                const SizedBox(width: 20), // Espacio entre los botones
                // Botón de "Continue"
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => QRScreen()), // Navega a InputDNI
                    );
                  },
                  
                  child: const Text('Continue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
