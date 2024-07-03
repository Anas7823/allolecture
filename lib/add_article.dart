// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Fonction pour ajouter un article via l'API
Future<void> addArticle(String type, String titre, String auteur,
    String description, String dateCreation) async {
  final response = await http.post(
    Uri.parse('http://10.74.3.201:8000/articles'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'type': type,
      'titre': titre,
      'auteur': auteur,
      'description': description,
      'dateCreation': dateCreation,
    }),
  );

  if (response.statusCode == 201) {
    print('Article ajouté avec succès.');
  } else {
    throw Exception('Échec de l\'ajout de l\'article.');
  }
}

class AddArticle extends StatelessWidget {
  AddArticle({super.key});

  // Clé pour identifier un formulaire et valider
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs pour les champs de texte
  final TextEditingController titreController = TextEditingController();
  final TextEditingController auteurController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateCreationController = TextEditingController();
  String _selectedType = 'Type1'; // Exemple de valeur initiale

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter un article')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: titreController,
              decoration: InputDecoration(labelText: 'Titre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un titre';
                }
                return null;
              },
            ),
            // Ajoutez d'autres TextFormField pour auteur, description, etc.
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  addArticle(
                          _selectedType,
                          titreController.text,
                          auteurController.text,
                          descriptionController.text,
                          dateCreationController.text)
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Article ajouté avec succès')));
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Erreur lors de l\'ajout de l\'article')));
                  });
                }
              },
              child: Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }
}
