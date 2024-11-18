// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:patients/inputCode.dart';
import 'dart:async';

class WelcomeScreen extends StatelessWidget {
  final String nombre;

  const WelcomeScreen({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InputCode()), // Reemplaza 'OtraPantalla' con el nombre de tu siguiente pantalla
      );
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  const TextSpan(text: '¡Bienvenido '),
                  TextSpan(
                    text: nombre,
                    style: const TextStyle(
                      color: Colors.green, // Cambia el color del nombre aquí
                    ),
                  ),
                  const TextSpan(text: '!',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10), // Espacio adicional entre el texto "¡Bienvenido!" y "Adelante"
            const Text(
              'Adelante',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/happy.png', // Imagen original
                  width: 150,
                  height: 150,
                  // Ajusta el ancho y alto de la imagen según tus necesidades
                ),
                const SizedBox(width: 20), // Espacio entre las dos imágenes
                Image.asset(
                  'images/arrow.png', // Ruta de la segunda imagen
                  width: 150,
                  height: 150,
                  // Ajusta el ancho y alto de la segunda imagen según tus necesidades
                ),
              ],
            ),
            const SizedBox(height: 20),
           
          ],
        ),
      ),
    );
  }
}
