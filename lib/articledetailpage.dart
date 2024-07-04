import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArticleDetailPage extends StatelessWidget {
  final int articleId;

  const ArticleDetailPage({Key? key, required this.articleId})
      : super(key: key);

  Future<Map<String, dynamic>> fetchArticleDetails(int idArt) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/articles/$idArt'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse[
          0]; // Assuming the API returns a list with one element
    } else {
      throw Exception('Failed to load article details');
    }
  }

  Future<double> fetchAverageNote(int idArt) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/notes/moyenne/$idArt'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return double.parse(jsonResponse[0]['AVG(note)']);
    } else {
      throw Exception('Failed to load average note for article $idArt');
    }
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return _RatingDialog(articleId: articleId);
      },
    );
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
            final article = snapshot.data!; // snapshot.data est un Map<String, dynamic>
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
                      "Lorem blablablbalbalbalablablablbalablaablablabalbalablablabalbalablalaballbalbalabblablablablablablbalbalbalablablablbalablaablablabalbalablablabalbalablalaballbalbalabblablablablablablbalbalbalablablablbalablaablablabalbalablablabalbalablalaballbalbalabblablabla"),
                  SizedBox(height: 16),
                  FutureBuilder<double>(
                    future: fetchAverageNote(articleId),
                    builder: (context, noteSnapshot) {
                      if (noteSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Text('Loading average note...');
                      } else if (noteSnapshot.hasError) {
                        return Text('Error: ${noteSnapshot.error}');
                      } else if (noteSnapshot.hasData) {
                        return Text(
                            'Note moyenne: ${noteSnapshot.data!.toStringAsFixed(2)}/5',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold));
                      } else {
                        return Text('No average note available');
                      }
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRatingDialog(context);
        },
        child: const Icon(Icons.star),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class _RatingDialog extends StatefulWidget {
  final int articleId;

  const _RatingDialog({Key? key, required this.articleId}) : super(key: key);

  @override
  __RatingDialogState createState() => __RatingDialogState();
}

class __RatingDialogState extends State<_RatingDialog> {
  int selectedRating = 0;

  Future<void> submitRating(int note, int idArt) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/notes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'note': note,
        'id_art': idArt,
      }),
    );

    if (response.statusCode == 200) {
      print('Note submitted successfully');
    } else {
      throw Exception('Failed to submit note');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate this article'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return IconButton(
            icon: Icon(
              index < selectedRating ? Icons.star : Icons.star_border,
            ),
            color: Colors.amber,
            onPressed: () {
              setState(() {
                selectedRating = index + 1;
              });
            },
          );
        }),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Submit'),
          onPressed: () {
            submitRating(selectedRating, widget.articleId).then((_) {
              Navigator.of(context).pop();
            }).catchError((error) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to submit rating: $error')),
              );
            });
          },
        ),
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
