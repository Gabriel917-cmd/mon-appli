import 'package:flutter/material.dart';

 class Prremier extends StatelessWidget {
   const Prremier({super.key});

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Image.asset("assets/images/Thesis-rafiki.png"),
             Text("profite d'une meilleur experience",
               style: TextStyle(
                 fontSize: 20,
               ),
             ),
             CustomButtom(

             )
           ],
         )
       ),
     );
   }
 }
