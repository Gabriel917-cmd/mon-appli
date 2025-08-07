import 'package:flutter/material.dart';

 class Validation extends StatefulWidget {
   const Validation({super.key});

   @override
   State<Validation> createState() => _ValidationState();
 }

 class _ValidationState extends State<Validation> {

   @override
   Widget build(BuildContext context) {
     return Scaffold(
         body: Container(
     decoration: const BoxDecoration(
     gradient: LinearGradient(
       begin: Alignment.topRight,
       end: Alignment.bottomLeft,
       colors: [
         Color(0xFF1976D2),
         Color(0xFF0D47A1),
       ],
     ),
     ),
           child: Column(
             children: [
               Text("code d'activation",
               style: TextStyle(
                 fontSize: 30,
                 color: Colors.white,
               ),
                 textAlign: TextAlign.center,
               )
             ],
           ),
         )
     );
   }
 }
