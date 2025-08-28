import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Postulation Stages',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const StageApplicationPage(),
    );
  }
}

class StageApplicationPage extends StatefulWidget {
  const StageApplicationPage({super.key});

  @override
  State<StageApplicationPage> createState() => _StageApplicationPageState();
}

class _StageApplicationPageState extends State<StageApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _ecoleController = TextEditingController();
  final TextEditingController _formationController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String? _cvPath;
  String? _lettreMotivationPath;
  List<String> _autresDocumentsPaths = [];
  DateTime? _dateDebutDispo;
  DateTime? _dateFinDispo;

  // Liste d'offres de stage simulées
  final List<Stage> offresStage = [
    Stage(
      id: "1",
      titre: "Développeur Flutter Mobile",
      entreprise: "Mercy Innovation Lab",
      localisation: "Nvan, Yaounde",
      duree: "2 à 3 mois",
      remuneration: "Rémunération : pas de remuneration",
      description: "Nous recherchons un étudiant passionné par le développement mobile avec Flutter. Vous participerez à la conception et au développement d'applications mobiles innovantes pour nos clients.",
      imageUrl: "https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
      competences: ["Flutter", "Dart", "Firebase", "UI/UX", "Git"],
      datePublication: "Publié il y a 2 jours",
    ),
    Stage(
      id: "2",
      titre: "Data Analyst",
      entreprise: "Data Solutions",
      localisation: "Lyon, France",
      duree: "4 à 6 mois",
      remuneration: "Rémunération : 1200€/mois",
      description: "Rejoignez notre équipe data pour analyser des jeux de données complexes et aider à la prise de décision stratégique. Connaissances en Python et SQL requises.",
      imageUrl: "https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
      competences: ["Python", "SQL", "Data Visualization", "Statistics"],
      datePublication: "Publié il y a 5 jours",
    ),
    Stage(
      id: "3",
      titre: "Designer UX/UI",
      entreprise: "Creative Minds",
      localisation: "Télétravail",
      duree: "3 mois",
      remuneration: "Rémunération : 900€/mois",
      description: "Nous cherchons un designer talentueux pour créer des interfaces utilisateur attrayantes et fonctionnelles. Maîtrise de Figma et Adobe XD nécessaire.",
      imageUrl: "https://images.unsplash.com/photo-1561070791-2526d30994b5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
      competences: ["Figma", "Adobe XD", "UI Design", "Wireframing"],
      datePublication: "Publié il y a 1 semaine",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offres de Stage'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // En-tête avec informations personnelles rapides
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage("assets/images/Capture d’écran du 2025-08-26 16-39-11.png"),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Gabriel Tchougang",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Licence Informatique - Université ",
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Barre de filtres
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.grey[100],
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text("Tous"),
                    selected: true,
                    onSelected: (bool value) {},
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text("Informatique"),
                    onSelected: (bool value) {},
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text("Marketing"),
                    onSelected: (bool value) {},
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text("Design"),
                    onSelected: (bool value) {},
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text("Finance"),
                    onSelected: (bool value) {},
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: offresStage.length,
              itemBuilder: (context, index) {
                return StageCard(stage: offresStage[index], onApply: _showApplicationForm);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showApplicationForm(Stage stage) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Postuler: ${stage.titre}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Informations personnelles
                  const Text(
                    "Informations personnelles",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
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
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

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
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _telephoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Téléphone",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Informations académiques
                  const Text(
                    "Informations académiques",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _ecoleController,
                    decoration: const InputDecoration(
                      labelText: "Établissement *",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre établissement';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _formationController,
                    decoration: const InputDecoration(
                      labelText: "Formation *",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre formation';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Disponibilités
                  const Text(
                    "Disponibilités",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 1),
                            );
                            if (picked != null) {
                              setState(() {
                                _dateDebutDispo = picked;
                              });
                            }
                          },
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: "Date de début",
                              border: OutlineInputBorder(),
                            ),
                            child: Text(
                              _dateDebutDispo != null
                                  ? DateFormat('dd/MM/yyyy').format(_dateDebutDispo!)
                                  : "Sélectionner",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 1),
                            );
                            if (picked != null) {
                              setState(() {
                                _dateFinDispo = picked;
                              });
                            }
                          },
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: "Date de fin",
                              border: OutlineInputBorder(),
                            ),
                            child: Text(
                              _dateFinDispo != null
                                  ? DateFormat('dd/MM/yyyy').format(_dateFinDispo!)
                                  : "Sélectionner",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Documents
                  const Text(
                    "Documents à joindre",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  _buildDocumentItem(
                    "CV *",
                    _cvPath,
                        () async {
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
                  const SizedBox(height: 8),

                  _buildDocumentItem(
                    "Lettre de motivation",
                    _lettreMotivationPath,
                        () async {
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
                  const SizedBox(height: 8),

                  _buildDocumentItem(
                    "Autres documents",
                    _autresDocumentsPaths.isNotEmpty ? _autresDocumentsPaths.join(", ") : null,
                        () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
                      );

                      if (result != null) {
                        setState(() {
                          _autresDocumentsPaths = result.paths.whereType<String>().toList();
                        });
                      }
                    },
                    isMultiple: true,
                  ),
                  const SizedBox(height: 16),

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
                  const SizedBox(height: 24),

                  // Bouton de soumission
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && _cvPath != null) {
                          _submitApplication(stage);
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Votre candidature a été envoyée avec succès!'),
                              backgroundColor: Colors.green,
                            ),
                          );
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
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
      },
    );
  }

  Widget _buildDocumentItem(String title, String? filePath, Function() onTap, {bool isMultiple = false}) {
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.description,
          color: filePath != null ? Colors.green : Colors.grey,
        ),
        title: Text(title),
        subtitle: filePath != null
            ? Text(
          isMultiple ? "$_autresDocumentsPaths.length fichiers" : filePath.split('/').last,
          overflow: TextOverflow.ellipsis,
        )
            : const Text("Aucun fichier sélectionné"),
        trailing: IconButton(
          icon: const Icon(Icons.attach_file),
          onPressed: onTap,
        ),
      ),
    );
  }

  void _submitApplication(Stage stage) {
    // Récupérer les données du formulaire
    String nom = _nomController.text;
    String prenom = _prenomController.text;
    String email = _emailController.text;
    String telephone = _telephoneController.text;
    String ecole = _ecoleController.text;
    String formation = _formationController.text;
    String message = _messageController.text;

    // Ici, vous pouvez envoyer les données à votre backend
    print("Candidature soumise pour: ${stage.titre}");
    print("Nom: $nom $prenom");
    print("Email: $email");
    print("Téléphone: $telephone");
    print("École: $ecole");
    print("Formation: $formation");
    print("CV: $_cvPath");
    print("Lettre de motivation: $_lettreMotivationPath");
    print("Autres documents: $_autresDocumentsPaths");
    print("Message: $message");
  }
}

class StageCard extends StatelessWidget {
  final Stage stage;
  final Function(Stage) onApply;

  const StageCard({super.key, required this.stage, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image de l'offre
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              image: DecorationImage(
                image: NetworkImage(stage.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre et entreprise
                Text(
                  stage.titre,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stage.entreprise,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),

                // Localisation et durée
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(stage.localisation, style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(width: 16),
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(stage.duree, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
                const SizedBox(height: 8),

                // Rémunération
                Text(
                  stage.remuneration,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  stage.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[800]),
                ),
                const SizedBox(height: 12),

                // Compétences requises
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: stage.competences.map((competence) {
                    return Chip(
                      label: Text(competence),
                      backgroundColor: Colors.blue[50],
                      labelStyle: const TextStyle(fontSize: 12),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Date de publication et bouton
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stage.datePublication,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                    ElevatedButton(
                      onPressed: () => onApply(stage),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Postuler",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Stage {
  final String id;
  final String titre;
  final String entreprise;
  final String localisation;
  final String duree;
  final String remuneration;
  final String description;
  final String imageUrl;
  final List<String> competences;
  final String datePublication;

  Stage({
    required this.id,
    required this.titre,
    required this.entreprise,
    required this.localisation,
    required this.duree,
    required this.remuneration,
    required this.description,
    required this.imageUrl,
    required this.competences,
    required this.datePublication,
  });
}