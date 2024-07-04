import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Ajout d'un padding autour de l'image
          child: Image.asset('images/React-JS.png'),
        ),
        title: const Text(
          'AlloLecture',
          style: TextStyle(
            color: Colors.white, // Couleur du texte
            fontSize: 24, // Taille de la police
            fontWeight: FontWeight.bold, // Style de police en gras
          ),
        ),
        backgroundColor: Color.fromARGB(255, 47, 111, 175), // Couleur de fond de la AppBar
        elevation: 4.0, // Élévation de la AppBar pour l'effet d'ombre
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Placeholder()),
              );
            },
          ),
        ],
      ),
      body: Center(child: Text('Contenu principal')), // Contenu de la page
    );
  }
}
