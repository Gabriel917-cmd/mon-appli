import 'package:flutter/material.dart';
import 'package:mon_appli/home/login_page.dart';

void main() => runApp(const CodeValidationAp());

class CodeValidationAp extends StatelessWidget {
  const CodeValidationAp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CodeEntryScreen(),
      routes: {
        '/changePassword': (context) => const ChangePasswordScreen(),
      },
    );
  }
}

class CodeEntryScreen extends StatefulWidget {
  const CodeEntryScreen({super.key});

  @override
  _CodeEntryScreenState createState() => _CodeEntryScreenState();
}

class _CodeEntryScreenState extends State<CodeEntryScreen> {
  final String validCode = "1234"; // Code valide
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  bool isError = false;
  bool _isResending = false;
  int _resendCountdown = 30; // 30 secondes avant de pouvoir renvoyer

  @override
  void initState() {
    super.initState();
    // Configuration du focus automatique
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.isNotEmpty && i < 3) {
          _focusNodes[i+1].requestFocus();
        }
      });
    }

    // Démarrer le compte à rebours
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendCountdown > 0) {
        setState(() => _resendCountdown--);
        _startCountdown();
      }
    });
  }

  Future<void> _resendCode() async {
    setState(() {
      _isResending = true;
      _resendCountdown = 30; // Réinitialiser le compte à rebours
    });

    // Simuler l'envoi du code (remplacer par votre logique réelle)
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isResending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Un nouveau code a été envoyé à votre email')),
      );
      _startCountdown();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _validateCode() {
    final enteredCode = _controllers.map((c) => c.text).join();
    if (enteredCode.length == 4) {
      if (enteredCode == validCode) {
        Navigator.pushNamed(context, '/changePassword');
      } else {
        setState(() {
          isError = true;
          // Efface le code après 1 seconde
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              for (var controller in _controllers) {
                controller.clear();
              }
              _focusNodes[0].requestFocus();
              isError = false;
            }
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validation du code',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.email, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                'Entrez le code à 4 chiffres',
                style: TextStyle(fontSize: 18),
              ),
              const Text(
                'envoyé à votre adresse email',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),

              // Cases de saisie avec TextField
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: isError ? Colors.red : Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: isError ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          _focusNodes[index+1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index-1].requestFocus();
                        }
                        if (index == 3 && value.isNotEmpty) {
                          _validateCode();
                        }
                      },
                    ),
                  );
                }),
              ),

              if (isError) ...[
                const SizedBox(height: 20),
                const Text(
                  'Code incorrect, veuillez réessayer',
                  style: TextStyle(color: Colors.red),
                ),
              ],

              const SizedBox(height: 30),

              // Bouton pour renvoyer le code
              TextButton(
                onPressed: _resendCountdown > 0 || _isResending
                    ? null
                    : _resendCode,
                child: _isResending
                    ? const CircularProgressIndicator()
                    : Text(
                  _resendCountdown > 0
                      ? 'Renvoyer le code ($_resendCountdown)'
                      : 'Renvoyer un nouveau code',
                  style: TextStyle(
                    color: _resendCountdown > 0 ? Colors.grey : Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Changer le mot de passe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  labelText: 'Nouveau mot de passe',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  if (value.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirmer le mot de passe',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Logique pour changer le mot de passe
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mot de passe changé avec succès')),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}