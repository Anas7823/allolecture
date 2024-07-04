import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArticleDetailPage extends StatelessWidget {
  final int articleId;

  const ArticleDetailPage({Key? key, required this.articleId})
      : super(key: key);

  Future<Map<String, dynamic>> fetchArticleDetails(int idArt) async {
    final response =
        await http.get(Uri.parse('http://10.74.3.201:8000/articles/$idArt'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse[
          0]; // Assuming the API returns a list with one element
    } else {
      throw Exception('Failed to load article details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'article'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchArticleDetails(articleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No details found'));
          } else {
            final article = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nom: ${article['nom_art']}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Créateur: ${article['createur_art']}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Durée / longueur: ${article['duree']}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Date de création: ${article['date_crea']}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 18),
                  Text(
                      "Lorem blablablbalbalbalablablablbalablaablablabalbalablablabalbalablalaballbalbalabblablablablablablbalbalbalablablablbalablaablablabalbalablablabalbalablalaballbalbalabblablablablablablbalbalbalablablablbalablaablablabalbalablablabalbalablalaballbalbalabblablablablablablbalbalbalablablablbalablaablablabalbalablablabalbalablalaballbalbalabblablablablablablbalbalbalablablablbalablaablablabalbalablablabalbalablalaballbalbalabblablabla")
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
