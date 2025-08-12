import 'package:flutter/material.dart';

  class HomePage extends StatelessWidget {
    const HomePage({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            items:[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "accuiel"),
          BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "accuiel"
          ),
            ]
        ),
      );
    }
  }
