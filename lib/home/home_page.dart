import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:mon_appli/home/accuiel/accuiel.dart';
import 'package:mon_appli/home/accuiel/actualites.dart';
import 'package:mon_appli/home/accuiel/chatbot.dart';
import 'package:mon_appli/home/accuiel/parametres.dart';
import 'package:mon_appli/home/accuiel/stage.dart';
  class HomePage extends StatefulWidget {
    const HomePage({super.key});


    @override
    State<HomePage> createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    int CurrentIndex = 2 ;


    setCurrentIndex (int index){
      setState(() {
        CurrentIndex = index;
      });
    }
    @override
    Widget build(BuildContext context) {
       return Scaffold(
         body: [
           StagePage(stage:Stage(id: '0000', titre: 'developpeur', entreprise: "Mercy innovation", localisation: "Nvan", description: "devellopeur mobile et web", imageUrl: "assets/images/Thesis-rafiki,png", competences: ["Flutter", "Dart", "Firebase", "UI/UX"],),),
           ChatBotApp(),
           Accuiel(),
           Actualites(),
           Parametres(),

         ][CurrentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: CurrentIndex,
            onTap: (index) => setCurrentIndex(index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white70,
            elevation: 12,
            items:[
              BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: "Stage"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chatbot'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Accuiel"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.watch_later_outlined),
                  label: "Actualite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Parametres"
              ),
            ]
        ),
      );
    }
  }

