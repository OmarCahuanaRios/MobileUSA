import 'package:flutter/material.dart';
import 'package:patients/inputDNI.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo oscuro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mensaje encima del QR
            const Text(
              'Scan the following QR to complete your registration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20), // Espacio entre el texto y el QR

            // Imagen del QR (se puede reemplazar con una URL o imagen local)
            Image.asset(
              'images/QR.png', // Asegúrate de tener la imagen del QR en la carpeta assets
              width: 200, // Tamaño de la imagen
              height: 200, // Tamaño de la imagen
            ),

            const SizedBox(height: 20), // Espacio entre la imagen y el botón

            // Botón "Continuar"
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón
                // Puedes navegar a otra pantalla o ejecutar alguna acción
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputDNI()), // Cambia `NextScreen()` por tu siguiente pantalla
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

// Puedes crear una pantalla siguiente para la navegación
class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Siguiente Pantalla')),
      body: const Center(child: Text('¡Has avanzado a la siguiente pantalla!')),
    );
  }
}
