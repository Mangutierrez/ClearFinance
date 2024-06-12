import 'package:flutter/material.dart';
import 'edit_profile_content.dart'; // Importa el archivo de edición de perfil

class PerfilContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfileContent()), // Navega a EditProfileContent
            );
          },
          child: const Text('Editar Perfil'),
        ),
      ),
    );
  }
}
