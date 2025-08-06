import 'package:flutter/material.dart';
import 'package:mon_appli/compoments/custom_buttom.dart';
import 'package:mon_appli/compoments/custom_textfiel.dart';
import 'package:mon_appli/home/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  void handleRegister(){
    setState(()
    => isLoading= true
    );

    Future.delayed(const Duration(seconds: 2), (){
      setState(()
      => isLoading = false
      );
      Navigator.pushReplacementNamed(context, '/home');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inscription"),
        centerTitle: true
        ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.person_add,color: Colors.blue,size: 100,),
            SizedBox(height: 20,),
            Text("Créer un compte",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),textAlign: TextAlign.center,
            ),
            Text("Remplissez les informations ci-dessous pour créer votre compte",
              style: TextStyle(color: Colors.grey.shade600,
              ),textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            CustomTextfield(
                prefixIcon: Icons.person,
                hintText: 'Nom complet', controller: nameController),
            const SizedBox(height: 12,),
            CustomTextfield(
                prefixIcon: Icons.mail,
                hintText: 'Adresse email', controller: emailController),
            const SizedBox(height: 12,),
            CustomTextfield(
              prefixIcon: Icons.lock,
              hintText: 'Mot de passe ',
              controller: passwordController,
              isPassword: true,
              suffixIcon: Icons.visibility,
            ),
            const SizedBox(height: 12,),
            CustomTextfield(
              hintText: 'Confirmer le mot de passe ',
              controller: passwordController,
              isPassword: true,
              suffixIcon: Icons.visibility,
            ),
            const SizedBox(height: 20,),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,

              children: [
                Icon(Icons.check_box_outline_blank),
                Text("     J'accepte les condition d'utiliation \n      et la politique de confidentialité",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            CustomButton(
              text: "S'inscrire",
              isLoading: isLoading,
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()),
              );
              },
            ),
          ],
        ),
      ),
    );
  }
}
