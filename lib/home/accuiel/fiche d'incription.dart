import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mon_appli/home/accuiel/stage.dart';


class FicheInscriptionPage extends StatefulWidget {
  final Stage stage;

  const FicheInscriptionPage({Key? key, required this.stage}) : super(key: key);

  @override
  _FicheInscriptionPageState createState() => _FicheInscriptionPageState();
}

class _FicheInscriptionPageState extends State<FicheInscriptionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String? _cvPath;
  String? _lettreMotivationPath;
  String? _autresDocumentsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fiche d'inscription"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informations sur le stage
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.stage.titre,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.stage.entreprise,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Formulaire d'inscription
              const Text(
                "Informations personnelles",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              // Nom
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: "Nom *",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Prénom
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(
                  labelText: "Prénom *",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre prénom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email *",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Téléphone
              TextFormField(
                controller: _telephoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Téléphone",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              // Message de motivation
              TextFormField(
                controller: _messageController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Message de motivation",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 20),

              // Documents à joindre
              const Text(
                "Documents à joindre",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              // CV
              Card(
                child: ListTile(
                  leading: const Icon(Icons.description, color: Colors.blue),
                  title: const Text("CV *"),
                  subtitle: _cvPath != null
                      ? Text(_cvPath!.split('/').last)
                      : const Text("Aucun fichier sélectionné"),
                  trailing: IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'doc', 'docx'],
                      );

                      if (result != null) {
                        setState(() {
                          _cvPath = result.files.single.path;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Lettre de motivation
              Card(
                child: ListTile(
                  leading: const Icon(Icons.description, color: Colors.blue),
                  title: const Text("Lettre de motivation"),
                  subtitle: _lettreMotivationPath != null
                      ? Text(_lettreMotivationPath!.split('/').last)
                      : const Text("Aucun fichier sélectionné"),
                  trailing: IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'doc', 'docx'],
                      );

                      if (result != null) {
                        setState(() {
                          _lettreMotivationPath = result.files.single.path;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Autres documents
              Card(
                child: ListTile(
                  leading: const Icon(Icons.description, color: Colors.blue),
                  title: const Text("Autres documents"),
                  subtitle: _autresDocumentsPath != null
                      ? Text(_autresDocumentsPath!.split('/').last)
                      : const Text("Aucun fichier sélectionné"),
                  trailing: IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
                      );

                      if (result != null) {
                        setState(() {
                          _autresDocumentsPath = result.files.first.path;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Bouton de soumission
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _cvPath != null) {
                      // Traitement des données du formulaire
                      _soumettreCandidature();

                      // Afficher un message de confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Votre candidature a été envoyée avec succès!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Retourner à la page précédente après un délai
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    } else if (_cvPath == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Veuillez joindre votre CV'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "SOUMETTRE MA CANDIDATURE",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _soumettreCandidature() {
    // Récupérer les données du formulaire
    String nom = _nomController.text;
    String prenom = _prenomController.text;
    String email = _emailController.text;
    String telephone = _telephoneController.text;
    String message = _messageController.text;

    // Ici, vous pouvez envoyer les données à votre backend
    // et uploader les fichiers

    print("Candidature soumise:");
    print("Nom: $nom");
    print("Prénom: $prenom");
    print("Email: $email");
    print("Téléphone: $telephone");
    print("Message: $message");
    print("CV: $_cvPath");
    print("Lettre de motivation: $_lettreMotivationPath");
    print("Autres documents: $_autresDocumentsPath");
    print("Stage: ${widget.stage.titre}");
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}