import 'package:flutter/material.dart';
import 'package:mon_appli/home/home_page.dart';
import 'package:mon_appli/home/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../compoments/custom_buttom.dart';
import '../compoments/custom_textfiel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAccepted = false;

  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? termsError;
  bool showErrors = false;

  // Fonction pour valider le format d'email
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Fonction pour valider tous les champs
  bool validateFields() {
    setState(() {
      nameError = null;
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;
      termsError = null;
    });

    bool isValid = true;

    // Validation du nom
    if (nameController.text.isEmpty) {
      setState(() => nameError = "Le nom est obligatoire");
      isValid = false;
    }

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

    // Validation de la confirmation du mot de passe
    if (confirmPasswordController.text.isEmpty) {
      setState(() => confirmPasswordError = "Veuillez confirmer votre mot de passe");
      isValid = false;
    } else if (passwordController.text != confirmPasswordController.text) {
      setState(() => confirmPasswordError = "Les mots de passe ne correspondent pas");
      isValid = false;
    }

    // Validation des conditions
    if (!_termsAccepted) {
      setState(() => termsError = "Vous devez accepter les conditions");
      isValid = false;
    }

    return isValid;
  }

  // Fonction d'inscription avec Firebase
  void handleRegister() async {
    setState(() => showErrors = true);

    // Valider les champs avant de procéder
    if (!validateFields()) {
      return;
    }

    setState(() => isLoading = true);

    try {
      // Création du compte avec Firebase
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Mise à jour du profil avec le nom complet
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(nameController.text.trim());

        // Envoyer un email de vérification (optionnel)
        await userCredential.user!.sendEmailVerification();

        // Si l'inscription réussit
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage())
        );
      }
    } on FirebaseAuthException catch (e) {
      // Gestion des erreurs spécifiques à Firebase
      String errorMessage = "Erreur d'inscription";

      if (e.code == 'email-already-in-use') {
        errorMessage = "Un compte existe déjà avec cet email";
      } else if (e.code == 'weak-password') {
        errorMessage = "Le mot de passe est trop faible";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Adresse email invalide";
      } else if (e.code == 'operation-not-allowed') {
        errorMessage = "L'inscription par email/mot de passe n'est pas activée";
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
                  Icons.person_add,
                  color: Colors.blue.shade800,
                  size: 50,
                ),
              ),
              const SizedBox(height: 30),

              // Titre
              const Text(
                "Créez votre compte",
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
                "Rejoignez-nous et commencez votre voyage",
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
                    // Champ nom complet
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nom complet',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextfield(
                          hintText: 'Votre nom complet',
                          controller: nameController,
                          prefixIcon: Icons.person,
                          errorText: showErrors ? nameError : null,
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          onSuffixPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

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
                          hintText: 'votre@email.com',
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
                          hintText: 'Créez un mot de passe',
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
                    const SizedBox(height: 20),

                    // Champ confirmation mot de passe
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Confirmer le mot de passe',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextfield(
                          hintText: 'Confirmez votre mot de passe',
                          controller: confirmPasswordController,
                          isPassword: _obscureConfirmPassword,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                          onSuffixPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                          errorText: showErrors ? confirmPasswordError : null,
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Checkbox conditions
                    Row(
                      children: [
                        Checkbox(
                          value: _termsAccepted,
                          onChanged: (value) {
                            setState(() {
                              _termsAccepted = value!;
                              if (_termsAccepted) {
                                termsError = null;
                              }
                            });
                          },
                          activeColor: Colors.blue.shade700,
                        ),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "J'accepte les ",
                                  style: TextStyle(fontSize: 14),
                                ),
                                TextSpan(
                                  text: "conditions d'utilisation",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (showErrors && termsError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          termsError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),

                    // Bouton d'inscription
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: "S'inscrire",
                        isLoading: isLoading,
                        onPressed: handleRegister,
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

              // Lien vers connexion
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Vous avez déjà un compte ? ",
                    style: TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage())
                      );
                    },
                    child: Text(
                      "Se connecter",
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}