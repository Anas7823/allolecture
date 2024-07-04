import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Applique un espacement régulier
          children: [
            Image.asset('images/React-JS.png',
                fit: BoxFit.cover, height: 32.0), // Ajuste la taille de l'image
            const Text(
              'AlloLecture',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 47, 111, 175),
      ),
      body: Center(
          child: Text('Contenu principal')), // Ajout d'un body pour le Scaffold
    );
  }
}
