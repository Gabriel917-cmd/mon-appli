import 'package:flutter/material.dart';
import 'package:mon_appli/home/forgot_page.dart';
import 'package:mon_appli/home/home_page.dart';
import 'package:mon_appli/home/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../compoments/custom_buttom.dart';
import '../compoments/custom_textfiel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  bool _obscurePassword = true;
  String? emailError;
  String? passwordError;
  bool showErrors = false;

  // Fonction pour valider le format d'email
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Fonction pour valider tous les champs
  bool validateFields() {
    setState(() {
      emailError = null;
      passwordError = null;
    });

    bool isValid = true;

    // Validation de l'email
    if (emailController.text.isEmpty) {
      setState(() => emailError = "L'email est obligatoire");
      isValid = false;
    } else if (!isValidEmail(emailController.text)) {
      setState(() => emailError = "Adresse email invalide");
      isValid = false;
    }

    // Validation du mot de passe
    if (passwordController.text.isEmpty) {
      setState(() => passwordError = "Le mot de passe est obligatoire");
      isValid = false;
    } else if (passwordController.text.length < 6) {
      setState(() => passwordError = "Le mot de passe doit contenir au moins 6 caractères");
      isValid = false;
    }

    return isValid;
  }

  // Fonction de connexion avec Firebase
  void handleLogin() async {
    setState(() => showErrors = true);

    // Valider les champs avant de procéder
    if (!validateFields()) {
      return;
    }

    setState(() => isLoading = true);

    try {
      // Tentative de connexion avec Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Si la connexion réussit
      if (userCredential.user != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage())
        );
      }
    } on FirebaseAuthException catch (e) {
      // Gestion des erreurs spécifiques à Firebase
      String errorMessage = "Erreur de connexion";

      if (e.code == 'user-not-found') {
        errorMessage = "Aucun utilisateur trouvé avec cet email";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Mot de passe incorrect";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Adresse email invalide";
      } else if (e.code == 'user-disabled') {
        errorMessage = "Ce compte a été désactivé";
      }

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          )
      );
    } catch (e) {
      // Erreur générale
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Une erreur s'est produite: ${e.toString()}"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          )
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 60),

              // Logo/Icone
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.blue.shade800,
                  size: 50,
                ),
              ),
              const SizedBox(height: 30),

              // Titre
              const Text(
                "Heureux de vous revoir",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Sous-titre
              const Text(
                "Connectez-vous pour accéder à votre compte",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Carte de formulaire
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Champ email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextfield(
                          hintText: 'Enterz votre adresse email.com',
                          controller: emailController,
                          prefixIcon: Icons.email,
                          errorText: showErrors ? emailError : null,
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          onSuffixPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Champ mot de passe
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mot de passe',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextfield(
                          hintText: 'Entrer votre mot de passe',
                          controller: passwordController,
                          isPassword: _obscurePassword,
                          prefixIcon: Icons.lock,
                          suffixIcon: _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          onSuffixPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          errorText: showErrors ? passwordError : null,
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Mot de passe oublié
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ForgotPage())
                          );
                        },
                        child: Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Bouton de connexion
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: "Se connecter",
                        isLoading: isLoading,
                        onPressed: handleLogin,
                        backgroundColor: Colors.blue.shade700,
                        textColor: Colors.white,
                        height: 50,

                        borderRadius: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Inscription
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Vous n'avez pas de compte ? ",
                    style: TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterPage())
                      );
                    },
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}