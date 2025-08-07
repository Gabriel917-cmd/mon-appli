import 'package:flutter/material.dart';
import 'package:mon_appli/compoments/custom_buttom.dart';
import 'package:mon_appli/compoments/custom_textfiel.dart';
import 'package:mon_appli/home/validation.dart';

  class ForgotPage extends StatefulWidget {
    const ForgotPage({super.key});

    @override
    State<ForgotPage> createState() => _ForgotPageState();
  }

  class _ForgotPageState extends State<ForgotPage> {
    final emailController = TextEditingController();
    @override
    Widget build(BuildContext context) {
      return Scaffold(
         body: Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
      children: [
        Text("mot de passe oublie",
        style: TextStyle(
          fontSize: 30,
        ) ,textAlign: TextAlign.center,
      ),
        SizedBox(height: 30),
      Icon(Icons.lock,color: Colors.blueAccent,size: 100,),
        SizedBox(height: 30),
           Text("veuillez saisir votre adresse email pour \nrecevoir le code d'activation",
           style: TextStyle(
             color: Colors.grey.shade600
           ),textAlign: TextAlign.center,
           ),
        SizedBox(height: 30),
        CustomTextfield(
            prefixIcon: Icons.mail,
            hintText: "adresse email valide",
            controller: emailController,
        ),
        SizedBox(height: 30),
        CustomButton(text: "envoyer", onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => Validation()),);
        }
          )


           ]
         )
      ),
      );
    }
  }
