// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:allolecture/dropdownlist.dart';
import 'package:allolecture/navbar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Navbar(),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Text('Top 5 loisirs!'),
          ),
          Container(
            alignment: Alignment.center,
            child: ExpansionTileExample(),
          ),
        ],
      ),
    );
  }
}
