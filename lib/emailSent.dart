import 'dart:async';
import 'package:flutter/material.dart';
import 'package:patients/inputCode.dart';

class EmailEnviadoScreen extends StatefulWidget {
  const EmailEnviadoScreen({super.key});

  @override
  _EmailEnviadoScreenState createState() => _EmailEnviadoScreenState();
}

class _EmailEnviadoScreenState extends State<EmailEnviadoScreen> {
  @override
  void initState() {
    super.initState();
    
    // Agrega un temporizador para redirigir a otra pantalla después de 3 segundos
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InputCode()), // Reemplaza OtraPantalla con el nombre de tu otra pantalla
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Email enviado!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10), // Ajusta la altura según prefieras
            const Text(
              'Por favor, verifique su correo',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20), // Ajusta la altura según prefieras
            Image.asset(
                  'images/happy.png', // Imagen original
                  width: 150,
                  height: 150,
                  // Ajusta el ancho y alto de la imagen según tus necesidades
                ),
          ],
        ),
        
        
      ),
    );
  }
}
