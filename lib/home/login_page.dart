import 'package:flutter/material.dart';
import 'package:mon_appli/compoments/custom_buttom.dart';
import 'package:mon_appli/compoments/custom_textfiel.dart';
import 'package:mon_appli/home/home_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
      => isLoading = true
      );
      Navigator.pushReplacementNamed(context, '/home');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("heureux de vous revoir"),
        centerTitle: true
        ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            children: [
              Icon(Icons.login,color: Colors.blue,size: 100,),
              SizedBox(height: 20,),
              Text("Se connecter a votre compte",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                ),textAlign: TextAlign.center,
              ),
              Text("Remplissez les informations ci-dessous pour vous connectez a votre compte",
                style: TextStyle(color: Colors.grey.shade600,
                ),textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              CustomTextfield(
                  prefixIcon: Icons.mail,
                  hintText: 'Adresse email',
                  controller: emailController),
              const SizedBox(height: 25,),
              CustomTextfield(
                prefixIcon: Icons.lock,
                hintText: 'Mot de passe ',
                controller: passwordController,
                isPassword: true,
                suffixIcon: Icons.visibility,
              ), const SizedBox(height: 12,),
              const SizedBox(height: 20,),
              CustomButton(
                text: " Se connecter ",
                isLoading: isLoading,
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()),
                );
                },

              ),
            ]
        ),
      ),
    );
  }
}
