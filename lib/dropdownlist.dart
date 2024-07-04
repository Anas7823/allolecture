// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'articledetailpage.dart'; // Import the new page 

class ExpansionTileExample extends StatefulWidget {
  const ExpansionTileExample({super.key});

  @override
  State<ExpansionTileExample> createState() => _ExpansionTileExampleState();
}

class _ExpansionTileExampleState extends State<ExpansionTileExample> {
  bool _customTileExpanded = false;
  late Future<List<dynamic>> categories;

  Future<double> fetchAverageNote(int idArt) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/notes/moyenne/$idArt'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return double.parse(jsonResponse[0]['AVG(note)']);
    } else {
      throw Exception('Failed to load average note for article $idArt');
    }
  }

  @override
  void initState() {
    super.initState();
    categories = fetchCategories();
  }

  Future<List<dynamic>> fetchCategories() async {
    print('enculer');

    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/categories'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<dynamic>> fetchTopCategories(int id_cat) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/notes/top/$id_cat'));
    print(response);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load top films for category $id_cat');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No categories found'));
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: snapshot.data!.map<Widget>((category) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFB9848C),
                      border: Border.all(color: Color.fromARGB(255, 47, 111, 175), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ExpansionTile(
                      title: Text(category['nom_cat']),
                      trailing: Icon(
                        _customTileExpanded
                            ? Icons.arrow_drop_down_circle
                            : Icons.arrow_drop_down,
                      ),
                      children: [
                        FutureBuilder<List<dynamic>>(
                          future: fetchTopCategories(category['id_cat']),
                          builder: (context, filmSnapshot) {
                            if (filmSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (filmSnapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${filmSnapshot.error}'));
                            } else if (!filmSnapshot.hasData ||
                                filmSnapshot.data!.isEmpty) {
                              return Center(
                                  child: Text(
                                      'No top films found for this category'));
                            } else {
                              return Column(
                                children:
                                    filmSnapshot.data!.map<Widget>((film) {
                                  return ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(film[
                                            'nom_art']), // Nom du film à gauche
                                        FutureBuilder<double>(
                                          future:
                                              fetchAverageNote(film['id_art']),
                                          builder: (context, noteSnapshot) {
                                            if (noteSnapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Text('Loading...');
                                            } else if (noteSnapshot.hasError) {
                                              return Text(
                                                  'Error: ${noteSnapshot.error}');
                                            } else if (noteSnapshot.hasData) {
                                              return Text(
                                                  'Note: ${noteSnapshot.data!.toStringAsFixed(2)}/5');
                                            } else {
                                              return Text('No data');
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      // Navigate to the detail page when tapped
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ArticleDetailPage(
                                            articleId: film['id_art'],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              );
                            }
                          },
                        ),
                      ],
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          _customTileExpanded = expanded;
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
