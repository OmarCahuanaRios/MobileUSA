// segunda_vista.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patients/byeUser.dart';
import 'package:patients/inputDNI.dart';
import 'package:patients/inputEmail.dart';
import 'package:patients/invalidCode.dart';
import 'package:patients/welcomeUser.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

class InputCode extends StatelessWidget {
  
  final TextEditingController dniController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  List<dynamic> workers  = [];
  List<dynamic> visitants = [];
  List<dynamic> codes = [];
  Object visitantBydni = {};
  Object workerByDni = {};
  bool isWorker = false;
  bool isVisitant = false;
  bool codeExistAndIsNotUsed = false;
  String nombreGlobal = "prueba?";
  int codigoObtenido = 0;
  String id = "";

  InputCode({super.key});


  

  Future<void> getAllCodes() async {
    var apiUrlCodes = 'http://192.168.1.36:8090/code';
    final responseDataCode = await http.get(Uri.parse(apiUrlCodes));
   
    codes = json.decode(responseDataCode.body);

    print("códigos");
    print(codes);
    for(var code in codes){

      if(code['code'] == codigoObtenido && code['used'] == false ){
        print("Llega 2");
        codeExistAndIsNotUsed = true;
      }
    }
  }


  
  @override
  Widget build(BuildContext context)  {
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Digite su código de acceso',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller:codeController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Código',
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
                codigoObtenido = int.parse(codeController.text);
                await getAllCodes();
                codeExistAndIsNotUsed ? Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen(nombre: 'Invitado')),
              ) : Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InvalidCodeScreen()),
              );
              },
              child: const Text('Ingresar'),
            ),
            const SizedBox(height: 20),
             GestureDetector(
            onTap: () {
              // Navegar a la otra pantalla aquí
              // Por ejemplo:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InputDNI()),
              );
            },child: const Text(
              'Soy Trabajador',
              style: TextStyle(
                color: Colors.blue, // Puedes personalizar el color
                decoration: TextDecoration.underline,
              ),)
            
            ),
            const SizedBox(height: 20),
            GestureDetector(
            onTap: () {
              // Navegar a la otra pantalla aquí
              // Por ejemplo:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InputEmail()),
              );
            },child: const Text(
              'No tengo un código de acceso',
              style: TextStyle(
                color: Colors.blue, // Puedes personalizar el color
                decoration: TextDecoration.underline,
              ),)
            
            ),
          ],
        ),
      ),
    );
  }
}
