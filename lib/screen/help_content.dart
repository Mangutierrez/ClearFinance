import 'package:flutter/material.dart';

class HelpContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayuda'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image
              Image.asset(
                'assets/logo.png', // Place your image in the assets folder and update the path accordingly
                height: 150,
              ),
              SizedBox(height: 20),
              // Title
              Text(
                'ClearFinance',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Description
              Text(
                'Tú app de finanzas favorita',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              // Links
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Integrantes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  // Integrantes list
                  for (var integrante in [
                    'Angello Stiven Andrade Chacón',
                    'Mónica Andrea Gutierrez Barbosa',
                    'Fabian Sebastian Tapiero Perez',
                    'Juan Sebastián Valderrama Dueñas',
                    'Oscar Yesid Gutierrez Parra'
                  ])
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        integrante,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
