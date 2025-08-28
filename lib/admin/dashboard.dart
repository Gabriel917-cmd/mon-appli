import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Admin - Orientation & Insertion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;
  int _selectedDrawerIndex = 0;

  // Données simulées
  final List<Etudiant> _etudiants = [
    Etudiant(
      id: "1",
      nom: "Dupont",
      prenom: "Marie",
      email: "marie.dupont@email.com",
      filiere: "Informatique",
      annee: "L3",
      dateInscription: DateTime.now().subtract(const Duration(days: 120)),
      status: "Actif",
      solde: 450.0,
    ),
    Etudiant(
      id: "2",
      nom: "Martin",
      prenom: "Luc",
      email: "luc.martin@email.com",
      filiere: "Commerce",
      annee: "M1",
      dateInscription: DateTime.now().subtract(const Duration(days: 200)),
      status: "Actif",
      solde: 320.0,
    ),
    Etudiant(
      id: "3",
      nom: "Bernard",
      prenom: "Sophie",
      email: "sophie.bernard@email.com",
      filiere: "Droit",
      annee: "L2",
      dateInscription: DateTime.now().subtract(const Duration(days: 90)),
      status: "Inactif",
      solde: 0.0,
    ),
  ];

  final List<DemandeStage> _demandesStage = [
    DemandeStage(
      id: "1",
      etudiantId: "1",
      etudiantNom: "Marie Dupont",
      entreprise: "Tech Innovations",
      poste: "Développeur Flutter",
      status: "En attente",
      date: DateTime.now().subtract(const Duration(days: 5)),
      duree: "6 mois",
      documents: ["CV.pdf", "Lettre.pdf"],
    ),
    DemandeStage(
      id: "2",
      etudiantId: "2",
      etudiantNom: "Luc Martin",
      entreprise: "Data Solutions",
      poste: "Data Analyst",
      status: "Approuvée",
      date: DateTime.now().subtract(const Duration(days: 10)),
      duree: "4 mois",
      documents: ["CV.pdf", "Lettre.pdf", "Relevé.pdf"],
    ),
    DemandeStage(
      id: "3",
      etudiantId: "3",
      etudiantNom: "Sophie Bernard",
      entreprise: "Legal Partners",
      poste: "Assistant juridique",
      status: "Rejetée",
      date: DateTime.now().subtract(const Duration(days: 15)),
      duree: "3 mois",
      documents: ["CV.pdf"],
    ),
  ];

  final List<Filiere> _filieres = [
    Filiere(
      id: "1",
      nom: "Informatique",
      description: "Formation en développement logiciel et bases de données",
      responsable: "Dr. Ahmed Khan",
      fraisInscription: 500.0,
      fraisMensuels: 300.0,
      places: 120,
      inscrits: 105,
      status: "Ouverte",
    ),
    Filiere(
      id: "2",
      nom: "Commerce",
      description: "Formation en marketing et management",
      responsable: "Dr. Sophie Martin",
      fraisInscription: 600.0,
      fraisMensuels: 350.0,
      places: 80,
      inscrits: 78,
      status: "Ouverte",
    ),
    Filiere(
      id: "3",
      nom: "Droit",
      description: "Formation en sciences juridiques",
      responsable: "Pr. Jean Dupont",
      fraisInscription: 550.0,
      fraisMensuels: 320.0,
      places: 100,
      inscrits: 92,
      status: "Ouverte",
    ),
  ];

  final List<Transaction> _transactions = [
    Transaction(
      id: "1",
      etudiantId: "1",
      etudiantNom: "Marie Dupont",
      type: "Paiement frais",
      montant: 300.0,
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: "Complété",
    ),
    Transaction(
      id: "2",
      etudiantId: "2",
      etudiantNom: "Luc Martin",
      type: "Paiement inscription",
      montant: 600.0,
      date: DateTime.now().subtract(const Duration(days: 8)),
      status: "Complété",
    ),
    Transaction(
      id: "3",
      etudiantId: "1",
      etudiantNom: "Marie Dupont",
      type: "Remboursement",
      montant: -150.0,
      date: DateTime.now().subtract(const Duration(days: 12)),
      status: "Complété",
    ),
  ];

  final List<Actualite> _actualites = [
    Actualite(
      id: "1",
      titre: "Forum de l'emploi 2023",
      auteur: "Service Orientation",
      date: DateTime.now().subtract(const Duration(days: 2)),
      contenu: "Le forum annuel de l'emploi aura lieu le 15 décembre...",
      status: "Publiée",
      type: "Événement",
    ),
    Actualite(
      id: "2",
      titre: "Nouveaux horaires de bibliothèque",
      auteur: "Marie Dupont",
      date: DateTime.now().subtract(const Duration(days: 1)),
      contenu: "La bibliothèque étend ses horaires d'ouverture...",
      status: "En attente",
      type: "Information",
    ),
    Actualite(
      id: "3",
      titre: "Atelier de préparation aux entretiens",
      auteur: "Luc Martin",
      date: DateTime.now().subtract(const Duration(hours: 5)),
      contenu: "Un atelier pour préparer vos entretiens d'embauche...",
      status: "Rejetée",
      type: "Atelier",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Administrateur'),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _buildCurrentPage(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Text(
                    "A",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Administrateur",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "admin@orientation.com",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'Tableau de bord', 0),
          _buildDrawerItem(Icons.school, 'Gestion des Étudiants', 1),
          _buildDrawerItem(Icons.work, 'Demandes de Stage', 2),
          _buildDrawerItem(Icons.menu_book, 'Filières', 3),
          _buildDrawerItem(Icons.attach_money, 'Finances', 4),
          _buildDrawerItem(Icons.article, 'Actualités', 5),
          _buildDrawerItem(Icons.check_circle, 'Validation Contenu', 6),
          Divider(),
          _buildDrawerItem(Icons.settings, 'Paramètres', 7),
          _buildDrawerItem(Icons.exit_to_app, 'Déconnexion', 8),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: _selectedDrawerIndex == index,
      onTap: () {
        setState(() {
          _selectedDrawerIndex = index;
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buildCurrentPage() {
    switch (_selectedDrawerIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildGestionEtudiants();
      case 2:
        return _buildDemandesStage();
      case 3:
        return _buildFilieres();
      case 4:
        return _buildFinances();
      case 5:
        return _buildActualites();
      case 6:
        return _buildValidationContenu();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    int totalEtudiants = _etudiants.length;
    int totalDemandes = _demandesStage.length;
    int totalActualites = _actualites.length;
    double revenusMensuels = _transactions
        .where((t) => t.montant > 0 && t.date.month == DateTime.now().month)
        .fold(0.0, (sum, item) => sum + item.montant);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tableau de bord',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          // Cartes de statistiques
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Étudiants', totalEtudiants, Icons.school, Colors.blue),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('Demandes', totalDemandes, Icons.work, Colors.green),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Actualités', totalActualites, Icons.article, Colors.orange),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('Revenus', revenusMensuels, Icons.attach_money, Colors.purple, isMoney: true),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Demandes en attente
          Text(
            'Demandes de stage en attente',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  for (var demande in _demandesStage.where((d) => d.status == "En attente"))
                    ListTile(
                      leading: Icon(Icons.work, color: Colors.blue),
                      title: Text(demande.etudiantNom),
                      subtitle: Text('${demande.poste} - ${demande.entreprise}'),
                      trailing: Chip(
                        label: Text(demande.status),
                        backgroundColor: Colors.orange,
                      ),
                      onTap: () {
                        setState(() {
                          _selectedDrawerIndex = 2;
                        });
                      },
                    ),
                  if (_demandesStage.where((d) => d.status == "En attente").isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Aucune demande en attente', style: TextStyle(color: Colors.grey)),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),

          // Actualités à valider
          Text(
            'Actualités à valider',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  for (var actualite in _actualites.where((a) => a.status == "En attente"))
                    ListTile(
                      leading: Icon(Icons.article, color: Colors.orange),
                      title: Text(actualite.titre),
                      subtitle: Text('Par ${actualite.auteur}'),
                      trailing: Chip(
                        label: Text(actualite.status),
                        backgroundColor: Colors.orange,
                      ),
                      onTap: () {
                        setState(() {
                          _selectedDrawerIndex = 6;
                        });
                      },
                    ),
                  if (_actualites.where((a) => a.status == "En attente").isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Aucune actualité à valider', style: TextStyle(color: Colors.grey)),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, dynamic value, IconData icon, Color color, {bool isMoney = false}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 40),
            SizedBox(height: 8),
            Text(
              isMoney ? '${value.toStringAsFixed(2)}€' : value.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _buildGestionEtudiants() {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gestion des Étudiants',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Nouvel étudiant'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _etudiants.length,
              itemBuilder: (context, index) {
                final etudiant = _etudiants[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${etudiant.prenom[0]}${etudiant.nom[0]}'),
                    ),
                    title: Text('${etudiant.prenom} ${etudiant.nom}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(etudiant.email),
                        Text('${etudiant.filiere} - ${etudiant.annee}'),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(
                        etudiant.status,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: etudiant.status == "Actif" ? Colors.green : Colors.red,
                    ),
                    onTap: () {
                      _showEtudiantDetails(etudiant);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemandesStage() {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Demandes de Stage',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: 'Toutes',
                  items: ['Toutes', 'En attente', 'Approuvées', 'Rejetées']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _demandesStage.length,
              itemBuilder: (context, index) {
                final demande = _demandesStage[index];
                Color statusColor;
                switch (demande.status) {
                  case "Approuvée":
                    statusColor = Colors.green;
                    break;
                  case "Rejetée":
                    statusColor = Colors.red;
                    break;
                  default:
                    statusColor = Colors.orange;
                }

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.work, color: statusColor),
                    title: Text('${demande.poste} - ${demande.entreprise}'),
                    subtitle: Text('Par ${demande.etudiantNom} • ${DateFormat('dd/MM/yyyy').format(demande.date)}'),
                    trailing: Chip(
                      label: Text(
                        demande.status,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: statusColor,
                    ),
                    onTap: () {
                      _showDemandeDetails(demande);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilieres() {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gestion des Filières',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Nouvelle filière'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filieres.length,
              itemBuilder: (context, index) {
                final filiere = _filieres[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.menu_book, color: Colors.blue),
                    title: Text(filiere.nom),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(filiere.description),
                        Text('Responsable: ${filiere.responsable}'),
                        Text('${filiere.inscrits} / ${filiere.places} étudiants'),
                        Text('Frais: ${filiere.fraisInscription}€ inscription + ${filiere.fraisMensuels}€/mois'),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(
                        filiere.status,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: filiere.status == "Ouverte" ? Colors.green : Colors.red,
                    ),
                    onTap: () {
                      _showFiliereDetails(filiere);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinances() {
    double totalRevenus = _transactions.where((t) => t.montant > 0).fold(0.0, (sum, item) => sum + item.montant);
    double totalDepenses = _transactions.where((t) => t.montant < 0).fold(0.0, (sum, item) => sum + item.montant);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gestion Financière',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          // Résumé financier
          Row(
            children: [
              Expanded(
                child: _buildFinanceCard('Revenus', totalRevenus, Colors.green),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildFinanceCard('Dépenses', totalDepenses, Colors.red),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildFinanceCard('Solde', totalRevenus + totalDepenses, Colors.blue),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Dernières transactions
          Text(
            'Dernières transactions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  for (var transaction in _transactions.take(5))
                    ListTile(
                      leading: Icon(
                        transaction.montant > 0 ? Icons.arrow_circle_down : Icons.arrow_circle_up,
                        color: transaction.montant > 0 ? Colors.green : Colors.red,
                      ),
                      title: Text('${transaction.type} - ${transaction.etudiantNom}'),
                      subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(transaction.date)),
                      trailing: Text(
                        '${transaction.montant > 0 ? '+' : ''}${transaction.montant.toStringAsFixed(2)}€',
                        style: TextStyle(
                          color: transaction.montant > 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinanceCard(String title, double amount, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '${amount.toStringAsFixed(2)}€',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActualites() {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gestion des Actualités',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Nouvelle actualité'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _actualites.length,
              itemBuilder: (context, index) {
                final actualite = _actualites[index];
                Color statusColor;
                switch (actualite.status) {
                  case "Publiée":
                    statusColor = Colors.green;
                    break;
                  case "Rejetée":
                    statusColor = Colors.red;
                    break;
                  default:
                    statusColor = Colors.orange;
                }

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.article, color: statusColor),
                    title: Text(actualite.titre),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Par ${actualite.auteur} • ${actualite.type}'),
                        Text(DateFormat('dd/MM/yyyy HH:mm').format(actualite.date)),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(
                        actualite.status,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: statusColor,
                    ),
                    onTap: () {
                      _showActualiteDetails(actualite);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationContenu() {
    final actualitesEnAttente = _actualites.where((a) => a.status == "En attente").toList();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Validation du Contenu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: actualitesEnAttente.isEmpty
                ? Center(
              child: Text(
                'Aucun contenu à valider',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: actualitesEnAttente.length,
              itemBuilder: (context, index) {
                final actualite = actualitesEnAttente[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          actualite.titre,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Par ${actualite.auteur} • ${actualite.type}'),
                        SizedBox(height: 8),
                        Text(actualite.contenu),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  actualite.status = "Rejetée";
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text('Rejeter'),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  actualite.status = "Publiée";
                                });
                              },
                              child: Text('Publier'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEtudiantDetails(Etudiant etudiant) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${etudiant.prenom} ${etudiant.nom}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${etudiant.email}'),
                Text('Filière: ${etudiant.filiere}'),
                Text('Année: ${etudiant.annee}'),
                Text('Statut: ${etudiant.status}'),
                Text('Solde: ${etudiant.solde.toStringAsFixed(2)}€'),
                Text('Inscrit le: ${DateFormat('dd/MM/yyyy').format(etudiant.dateInscription)}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _showDemandeDetails(DemandeStage demande) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Demande de stage'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Étudiant: ${demande.etudiantNom}'),
                Text('Entreprise: ${demande.entreprise}'),
                Text('Poste: ${demande.poste}'),
                Text('Durée: ${demande.duree}'),
                Text('Statut: ${demande.status}'),
                Text('Date: ${DateFormat('dd/MM/yyyy').format(demande.date)}'),
                SizedBox(height: 8),
                Text('Documents:'),
                for (var doc in demande.documents) Text('- $doc'),
              ],
            ),
          ),
          actions: [
            if (demande.status == "En attente") ...[
              TextButton(
                onPressed: () {
                  setState(() {
                    demande.status = "Rejetée";
                  });
                  Navigator.pop(context);
                },
                child: Text('Rejeter', style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    demande.status = "Approuvée";
                  });
                  Navigator.pop(context);
                },
                child: Text('Approuver'),
              ),
            ],
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _showFiliereDetails(Filiere filiere) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(filiere.nom),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description: ${filiere.description}'),
                Text('Responsable: ${filiere.responsable}'),
                Text('Places: ${filiere.places}'),
                Text('Inscrits: ${filiere.inscrits}'),
                Text('Frais d\'inscription: ${filiere.fraisInscription}€'),
                Text('Frais mensuels: ${filiere.fraisMensuels}€'),
                Text('Statut: ${filiere.status}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _showActualiteDetails(Actualite actualite) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(actualite.titre),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Auteur: ${actualite.auteur}'),
                Text('Type: ${actualite.type}'),
                Text('Date: ${DateFormat('dd/MM/yyyy HH:mm').format(actualite.date)}'),
                Text('Statut: ${actualite.status}'),
                SizedBox(height: 8),
                Text('Contenu:'),
                Text(actualite.contenu),
              ],
            ),
          ),
          actions: [
            if (actualite.status == "En attente") ...[
              TextButton(
                onPressed: () {
                  setState(() {
                    actualite.status = "Rejetée";
                  });
                  Navigator.pop(context);
                },
                child: Text('Rejeter', style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    actualite.status = "Publiée";
                  });
                  Navigator.pop(context);
                },
                child: Text('Publier'),
              ),
            ],
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}

// Modèles de données
class Etudiant {
  final String id;
  final String nom;
  final String prenom;
  final String email;
  final String filiere;
  final String annee;
  final DateTime dateInscription;
  final String status;
  final double solde;

  Etudiant({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.filiere,
    required this.annee,
    required this.dateInscription,
    required this.status,
    required this.solde,
  });
}

class DemandeStage {
  final String id;
  final String etudiantId;
  final String etudiantNom;
  final String entreprise;
  final String poste;
  String status;
  final DateTime date;
  final String duree;
  final List<String> documents;

  DemandeStage({
    required this.id,
    required this.etudiantId,
    required this.etudiantNom,
    required this.entreprise,
    required this.poste,
    required this.status,
    required this.date,
    required this.duree,
    required this.documents,
  });
}

class Filiere {
  final String id;
  final String nom;
  final String description;
  final String responsable;
  final double fraisInscription;
  final double fraisMensuels;
  final int places;
  final int inscrits;
  final String status;

  Filiere({
    required this.id,
    required this.nom,
    required this.description,
    required this.responsable,
    required this.fraisInscription,
    required this.fraisMensuels,
    required this.places,
    required this.inscrits,
    required this.status,
  });
}

class Transaction {
  final String id;
  final String etudiantId;
  final String etudiantNom;
  final String type;
  final double montant;
  final DateTime date;
  final String status;

  Transaction({
    required this.id,
    required this.etudiantId,
    required this.etudiantNom,
    required this.type,
    required this.montant,
    required this.date,
    required this.status,
  });
}

class Actualite {
  final String id;
  final String titre;
  final String auteur;
  final DateTime date;
  final String contenu;
  String status;
  final String type;

  Actualite({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.date,
    required this.contenu,
    required this.status,
    required this.type,
  });
}