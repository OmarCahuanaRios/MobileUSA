// segunda_vista.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patients/byeUser.dart';
import 'package:patients/emailSent.dart';
import 'package:patients/welcomeUser.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class InputEmail extends StatelessWidget {
  final smtpServer = gmail('omaroceanuz@gmail.com', 'rxtm qmcw pugv vcfa');
  final TextEditingController emailController=TextEditingController();
  List<dynamic> workers  = [];
  List<dynamic> visitants = [];
  Object visitantBydni = {};
  Object workerByDni = {};
  bool isWorker = false;
  bool isVisitant = false;
  String nombreGlobal = "prueba?";

  String id = "";

  InputEmail({super.key});

  

  void getAllWorkers() async {
    const apiUrlWorkers = 'http://172.16.5.39:8090/worker';
    final responseDataWorkers = await http.get(Uri.parse(apiUrlWorkers));
    workers = json.decode(responseDataWorkers.body);
  }

  void getAllVisitants() async {
    const apiUrlVisitants = 'http://172.16.5.39:8090/visitant';
    final responseDataVisitants = await http.get(Uri.parse(apiUrlVisitants));
    visitants = json.decode(responseDataVisitants.body);
  }

  Future<void> getVisitantByDni(String dni) async {
    var apiUrlVisitants = 'http://172.16.5.39:8090/visitant/dni/$dni';
    final responseDataVisitantByDni = await http.get(Uri.parse(apiUrlVisitants));
    visitantBydni = json.decode(responseDataVisitantByDni.body);
    String nombreVisitant = (visitantBydni as Map<String, dynamic>)['firstName'];
    String apellidoVisitant = (visitantBydni as Map<String, dynamic>)['lastName'];
     nombreGlobal = "$nombreVisitant $apellidoVisitant";
    print("ESTE ES EL VISITANT ENTONCES");
    print(visitantBydni);

  }

  Future<void> getWorkerByDni(String dni) async {
    var apiUrlWorkers = 'http://172.16.5.39:8090/worker/dni/$dni';
    final responseDataWorkerByDni = await http.get(Uri.parse(apiUrlWorkers));
    workerByDni = json.decode(responseDataWorkerByDni.body);

    print("ESTE ES EL WORKER ENTONCES");
    print(workerByDni);
    String nombreWorker = (workerByDni as Map<String, dynamic>)['firstName'];
    String apellidoWorker = (workerByDni as Map<String, dynamic>)['lastName'];
     nombreGlobal = "$nombreWorker $apellidoWorker";
     print("NOMBRE DEL WORKER");
     print(nombreWorker);
     print("APELLIDO DEL WORKER");
     print(apellidoWorker);
     print("NOMBRE COMPLETO");
     print(nombreGlobal);
  }

 

   bool verificarDni(String dni)  {
    if (workers.any((worker) => worker['documentId'] == dni))  {
      isWorker = true;
      print("El DNI existe en la base de datos");
      return true;
    }
    if (visitants.any((visitant) => visitant['documentId'] == dni)){
      isVisitant = true;
      return true;
    }
    

    return false;
  }

  
 


  
  @override
  Widget build(BuildContext context) {
    getAllVisitants();
    getAllWorkers();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ingrese su correo',
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
                controller:emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
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
                String email = emailController.text;
                final message = Message()
                            ..from = const Address('omaroceanuz@gmail.com', 'Golf Los Inkas')
                            ..recipients.add(email)
                            ..subject = 'Formulario de Visitas'
                            ..text = 'Por favor ingrese al siguiente Link y llene sus datos en: http://localhost:4200/form';
                         Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const EmailEnviadoScreen()),
                        );
                        
                        try {
                            // Envía el correo electrónico
                            final sendReport = await send(message, smtpServer);
                            print('Correo enviado: ${sendReport.toString()}');
                          } on MailerException catch (e) {
                            print('Error al enviar el correo: $e');
                          }
                        
                       

               
              },
              child: const Text('Enviar'),
            ),
            const SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}
