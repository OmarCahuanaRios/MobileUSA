// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:patients/inputCode.dart';
import 'dart:async';

class InvalidCodeScreen extends StatelessWidget {
  

  const InvalidCodeScreen({super.key});

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
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  
                  TextSpan(text: 'Código Inválido'),
                  
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/sad.png', // Imagen original
                  width: 150,
                  height: 150,
                  // Ajusta el ancho y alto de la imagen según tus necesidades
                ),
                const SizedBox(width: 20), // Espacio entre las dos imágenes
                Image.asset(
                  'images/redmark.webp', // Ruta de la segunda imagen
                  width: 100,
                  height: 100,
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
