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
            const Text('AlloLecture'),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
