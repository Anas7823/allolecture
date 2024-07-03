// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ExpansionTileExample extends StatefulWidget {
  const ExpansionTileExample({super.key});

  @override
  State<ExpansionTileExample> createState() => _ExpansionTileExampleState();
}

class _ExpansionTileExampleState extends State<ExpansionTileExample> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFB9848C),
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ExpansionTile(
              title: const Text('Film'),
              trailing: Icon(
                _customTileExpanded
                    ? Icons.arrow_drop_down_circle
                    : Icons.arrow_drop_down,
              ),
              children: const <Widget>[
                ListTile(title: Text('numbah 1')),
                ListTile(title: Text('numbah 2')),
                ListTile(title: Text('numbah 3')),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _customTileExpanded = expanded;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFB9848C),
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ExpansionTile(
              title: const Text('Série'),
              trailing: Icon(
                _customTileExpanded
                    ? Icons.arrow_drop_down_circle
                    : Icons.arrow_drop_down,
              ),
              children: const <Widget>[
                ListTile(title: Text('série 1')),
                ListTile(title: Text('série 2')),
                ListTile(title: Text('série 3')),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _customTileExpanded = expanded;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
