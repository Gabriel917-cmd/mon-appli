import 'package:flutter/material.dart';
import 'package:mon_appli/home/accuiel/universite/Prog_mobile.dart';

class Accuiel extends StatefulWidget {
  const Accuiel({super.key});

  @override
  State<Accuiel> createState() => _HomePageState();
}

class _HomePageState extends State<Accuiel> {
  // Liste des filières disponibles
  final List<String> _filieres = [
  'Toutes les filières',
  'Informatique',
  'Génie Civil',
  'Électronique',
  'Mécanique',
  'Commerce',
  'Droit',
  'Agriculture',
  'Elevege'
  ];

  // Liste des matières avec leurs filières
  final List<Map<String, dynamic>> _matieres = [
  {
  'nom': 'Programmation Mobile',
  'filière': 'Informatique',
  'icône': Icons.phone_android,
  'couleur': Colors.blue,
  },
  {
  'nom': 'Base de Données',
  'filière': 'Informatique',
  'icône': Icons.storage,
  'couleur': Colors.green,
  },
  {
  'nom': 'Réseaux',
  'filière': 'Informatique',
  'icône': Icons.lan,
  'couleur': Colors.orange,
  },
    {
  'nom': 'Securite',
  'filière': 'Informatique',
  'icône': Icons.security,
  'couleur': Colors.green,
  },
   {
  'nom': 'Résistance des Matériaux',
  'filière': 'Génie Civil',
  'icône': Icons.architecture,
  'couleur': Colors.red,
  },
    {
  'nom': 'Energie renouvelable',
  'filière': 'Génie Mecanique',
  'icône': Icons.solar_power,
  'couleur': Colors.yellow,
  },
  {
  'nom': 'Mécanique des Fluides',
  'filière': 'Génie Civil',
  'icône': Icons.waves,
  'couleur': Colors.blue,
  },
  {
  'nom': 'Circuits Électroniques',
  'filière': 'Électronique',
  'icône': Icons.electrical_services,
  'couleur': Colors.purple,
  },
  {
  'nom': 'Théorie des Machines',
  'filière': 'Mécanique',
  'icône': Icons.build,
  'couleur': Colors.brown,
  },
  {
  'nom': 'Marketing Digital',
  'filière': 'Commerce',
  'icône': Icons.trending_up,
  'couleur': Colors.indigo,
  },
  {
  'nom': 'Droit des Affaires',
  'filière': 'Droit',
  'icône': Icons.gavel,
  'couleur': Colors.blueGrey,
  },
  {
  'nom': 'Comptabilité',
  'filière': 'Commerce',
  'icône': Icons.calculate,
  'couleur': Colors.teal,
  },
  ];

  String _filiereSelectionnee = 'Toutes les filières';
  final TextEditingController _rechercheController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final matieresFiltrees = _filiereSelectionnee== 'Toutes les filières'
    ? _matieres
        : _matieres.where((matiere) => matiere['filière'] == _filiereSelectionnee).toList();

    // Filtrer par recherche si un terme est saisi
    final matieresRecherchees = _rechercheController.text.isEmpty
    ? matieresFiltrees
        : matieresFiltrees.where((matiere) =>
    matiere['nom'].toLowerCase().contains(_rechercheController.text.toLowerCase()) ||
    matiere['filière'].toLowerCase().contains(_rechercheController.text.toLowerCase()))
        .toList();

    return Scaffold(
    appBar: AppBar(
    title: const Text('Matières'),
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    elevation: 0,
    ),
    body: Column(
    children: [
    Container(
    padding: const EdgeInsets.all(16),
    color: Colors.grey.shade50,
    child: Column(
    children: [
    TextField(
    controller: _rechercheController,
    decoration: InputDecoration(
    hintText: 'Rechercher une matière...',
    prefixIcon: const Icon(Icons.search),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    filled: true,
    fillColor: Colors.white38,
    ),
    onChanged: (value) {
    setState(() {});
    },
    ),
    const SizedBox(height: 16),
    SizedBox(
    height: 50,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: _filieres.length,
    itemBuilder: (context, index) {
    final filiere = _filieres[index];
    return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: FilterChip(
    label: Text(filiere),
    selected: _filiereSelectionnee == filiere,
    onSelected: (selected) {
    setState(() {
    _filiereSelectionnee = selected ? filiere : 'Toutes les filières';
    });
    },
    backgroundColor: Colors.white,
    selectedColor: Colors.blue.shade100,
    labelStyle: TextStyle(
    color: _filiereSelectionnee == filiere
    ? Colors.blue.shade800
        : Colors.grey.shade700,
    fontWeight: _filiereSelectionnee == filiere
    ? FontWeight.bold
        : FontWeight.normal,
    ),
    shape: StadiumBorder(
    side: BorderSide(
    color: _filiereSelectionnee == filiere
    ? Colors.blue
        : Colors.grey.shade300,
    ),
    ),
    ),
    );
    },
    ),
    ),
    ],
    ),
    ),
    Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    '${matieresRecherchees.length} matière(s) trouvée(s)',
    style: const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    ),
    ),
    if (_filiereSelectionnee != 'Toutes les filières')
    Chip(
    label: Text(
    _filiereSelectionnee,
    style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.blue,
    ),
    ],
    ),
    ),
    Expanded(
    child: matieresRecherchees.isEmpty
    ? const Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Icon(Icons.search_off, size: 64, color: Colors.grey),
    SizedBox(height: 16),
    Text(
    'Aucune matière trouvée',
    style: TextStyle(
    fontSize: 18,
    color: Colors.grey,
    ),
    ),
    ],
    ),
    )
        : ListView.builder(
    padding: const EdgeInsets.only(bottom: 16),
    itemCount: matieresRecherchees.length,
    itemBuilder: (context, index) {
    final matiere = matieresRecherchees[index];
    return Card(
    margin: const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
    ),
    elevation: 2,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
    leading: Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
    color: matiere['couleur'].withOpacity(0.2),
    shape: BoxShape.circle,
    ),
    child: Icon(
    matiere['icône'],
    color: matiere['couleur'],
    size: 28,
    ),
    ),
    title: Text(
    matiere['nom'],
    style: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    ),
    ),
    subtitle: Text(
    matiere['filière'],
    style: TextStyle(
    color: Colors.grey.shade600,
    ),
    ),
    trailing: const Icon(
    Icons.arrow_forward_ios,
    size: 16,
    color: Colors.grey,
    ),
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProgMobile())
      );
    },
    contentPadding: const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
    ),
    ),
    );
    },
    ),
    ),
    ],
    ),
    floatingActionButton: FloatingActionButton(
    onPressed: () {
    },
    backgroundColor: Colors.blue,
    child: const Icon(Icons.add, color: Colors.white),
    ),
    );
  }

  @override
  void dispose() {
    _rechercheController.dispose();
    super.dispose();
  }
}