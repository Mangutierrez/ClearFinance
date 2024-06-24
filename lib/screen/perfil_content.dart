import 'package:flutter/material.dart';
import 'package:clear_finance/data/profile_data.dart';
import 'edit_profile_content.dart';

class PerfilContent extends StatefulWidget {
  @override
  _PerfilContentState createState() => _PerfilContentState();
}

class _PerfilContentState extends State<PerfilContent> {
  @override
  Widget build(BuildContext context) {
    final profile = ProfileData.profile;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: profile.avatar,
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      bool? updated = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfileContent()),
                      );
                      if (updated != null && updated) {
                        setState(() {});
                      }
                    },
                    child: Text(
                      'Editar Perfil',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text("Nombre", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(profile.name),
            SizedBox(height: 10),
            Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(profile.email),
            SizedBox(height: 10),
            Text("Edad", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(profile.age.toString()),
            SizedBox(height: 10),
            Text("Género", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(profile.gender),
            SizedBox(height: 10),
            Text("Bio", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(profile.bio),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Metas',
          ),
        ],
      ),
    );
  }
}
