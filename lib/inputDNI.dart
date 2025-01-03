import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:excel/excel.dart';
import 'package:patients/byeUser.dart';
import 'package:patients/welcomeUser.dart';
import 'package:patients/qrscreen.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';

class InputDNI extends StatefulWidget {
  const InputDNI({super.key});

  @override
  _InputDNI createState() => _InputDNI();
}

class _InputDNI extends State<InputDNI> {
  final TextEditingController dniController = TextEditingController();
  bool _isFound = false; // Para saber si encontramos el nombre
  String nombreGlobal = "prueba?"; // Para almacenar el nombre encontrado

  // Ruta fija del archivo Excel
  String filePath = 'assets/clients.xlsx'; // Asegúrate de colocar tu archivo aquí o especifica la ruta correcta

  // Esta función ahora busca directamente en el archivo que ya existe
  Future<void> _pickFileAndSearchName(String name) async {
    // Obtén la ruta del archivo Excel desde los assets o almacenamiento
    ByteData data = await rootBundle.load(filePath);  // Cargar el archivo desde los assets
    List<int> bytes = data.buffer.asUint8List();
    
    var excel = Excel.decodeBytes(bytes);

    bool found = false;
    
    // Iterar sobre las hojas y celdas del archivo Excel buscando el nombre completo
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row.length > 1) { // Verificamos que la fila tenga al menos 2 celdas (nombre y apellido)
          String firstName = row[0]?.value.toString().trim() ?? ""; // Nombre en la columna A
          String lastName = row[1]?.value.toString().trim() ?? ""; // Apellido en la columna B
          String fullName = "$firstName $lastName";
          if (fullName.toLowerCase() == name.toLowerCase()) {
            setState(() {
              _isFound = true; // Nombre encontrado
              nombreGlobal = fullName; // Guardar el nombre completo encontrado
            });
            found = true;
            break;
          }
        }
      }
      if (found) break;
    }

    if (!found) {
      setState(() {
        _isFound = false; // Nombre no encontrado
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen arriba de todo
            Image.asset(
              'images/logo.png',  // Reemplaza con la ruta de tu imagen
              width: 300,  // Ajusta el tamaño de la imagen según tus necesidades
              height: 100,
            ),
            const SizedBox(height: 40), // Espacio entre la imagen y el siguiente texto
            const Text(
              'Welcome to Social Capital - Cultivando Talento event, hosted by the Latin American Chamber of Commerce of Charlotte!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20), 
            const Text(
              'Please type your name to check in',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: dniController,  // El controlador sigue siendo el mismo
                keyboardType: TextInputType.text, 
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]*$')),  
                  LengthLimitingTextInputFormatter(30), 
                ],
                decoration: InputDecoration(
                  labelText: 'name',  
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String name = dniController.text.trim();
                
                // Llamar a la función que busca el nombre en el archivo Excel
                await _pickFileAndSearchName(name);

                // Si se encuentra el nombre, llevar a la pantalla de bienvenida
                if (_isFound) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen(nombre: nombreGlobal)),
                  );
                } else {
                  // Si no se encuentra, mostrar pantalla de adiós
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ByeUserScreen()),
                  );
                }
              },
              child: const Text('Send'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QRScreen()),
                );
              },
              child: const Text(
                'Would you like to register?',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
