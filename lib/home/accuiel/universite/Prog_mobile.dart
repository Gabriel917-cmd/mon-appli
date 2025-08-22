import 'package:flutter/material.dart';

class ProgMobile extends StatelessWidget {
  const ProgMobile({super.key});

  // Liste des universités avec informations détaillées
  final List<Map<String, dynamic>> _universities = const [
    {
      'name': 'Université de Yaoundé I',
      'location': 'Yaoundé',
      'programs': ['Licence en Informatique', 'Master en Développement Mobile'],
      'image': 'assets/uni_yaounde1.jpg',
      'rating': 4.5,
      'admissionType': 'Concours',
      'admissionDetails': 'Concours national organisé par le MINESUP',
      'fees': '50 000 - 500 000 FCFA/an',
      'scholarship': 'Bourses gouvernementales disponibles',
      'website': 'www.univ-yaounde1.cm',
    },
    {
      'name': 'Université de Douala',
      'location': 'Douala',
      'programs': ['Ingénierie Informatique', 'Spécialisation Mobile'],
      'image': 'assets/uni_douala.jpg',
      'rating': 4.3,
      'admissionType': 'Dossier + Entretien',
      'admissionDetails': 'Sélection sur étude de dossier et entretien oral',
      'fees': '75 000 - 750 000 FCFA/an',
      'scholarship': 'Bourses d\'excellence et aides financières',
      'website': 'www.univ-douala.cm',
    },
    {
      'name': 'Université de Dschang',
      'location': 'Dschang',
      'programs': ['Génie Logiciel', 'Applications Mobiles'],
      'image': 'assets/uni_dschang.jpg',
      'rating': 4.2,
      'admissionType': 'Concours',
      'admissionDetails': 'Concours pour l\'accès aux filières scientifiques',
      'fees': '45 000 - 400 000 FCFA/an',
      'scholarship': 'Programmes de bourses régionaux',
      'website': 'www.univ-dschang.cm',
    },
    {
      'name': 'Université de Ngaoundéré',
      'location': 'Ngaoundéré',
      'programs': ['Informatique Fondamentale', 'Développement Mobile'],
      'image': 'assets/uni_ngaoundere.jpg',
      'rating': 4.0,
      'admissionType': 'Baccalauréat',
      'admissionDetails': 'Admission sur base du baccalauréat scientifique',
      'fees': '40 000 - 350 000 FCFA/an',
      'scholarship': 'Bourses pour étudiants méritants',
      'website': 'www.univ-ngaoundere.cm',
    },
    {
      'name': 'Université de Buea',
      'location': 'Buea',
      'programs': ['Computer Science', 'Mobile Technology'],
      'image': 'assets/uni_buea.jpg',
      'rating': 4.4,
      'admissionType': 'Concours + Dossier',
      'admissionDetails': 'Concours et examen rigoureux des dossiers',
      'fees': '100 000 - 800 000 FCFA/an',
      'scholarship': 'Bourses internationales et locales',
      'website': 'www.ubuea.cm',
    },
    {
      'name': 'ISTDI (Institut Supérieur de Technologies Digitales et d\'Innovation)',
      'location': 'Yaoundé',
      'programs': ['Développement Mobile Avancé', 'Flutter & React Native'],
      'image': 'assets/istdi.jpg',
      'rating': 4.7,
      'admissionType': 'Dossier + Test',
      'admissionDetails': 'Test technique et entretien motivationnel',
      'fees': '300 000 - 1 200 000 FCFA/an',
      'scholarship': 'Paiement échelonné et bourses entreprise',
      'website': 'www.istdi.cm',
    },
    {
      'name': 'SUP\'INFO Cameroun',
      'location': 'Douala',
      'programs': ['Expert en Développement Mobile', 'iOS & Android'],
      'image': 'assets/supinfo.jpg',
      'rating': 4.6,
      'admissionType': 'Entretien',
      'admissionDetails': 'Entretien de motivation et test de logique',
      'fees': '350 000 - 1 500 000 FCFA/an',
      'scholarship': 'Financement partenaire et bourses talent',
      'website': 'www.supinfo.cm',
    },
    {
      'name': 'ESGI (École Supérieure de Génie Informatique)',
      'location': 'Yaoundé',
      'programs': ['Ingénierie des Applications Mobiles'],
      'image': 'assets/esgi.jpg',
      'rating': 4.3,
      'admissionType': 'Dossier + Concours',
      'admissionDetails': 'Examen écrit et entretien technique',
      'fees': '400 000 - 1 800 000 FCFA/an',
      'scholarship': 'Bourses excellence et aides financières',
      'website': 'www.esgi-cameroun.cm',
    },
    {
      'name': 'UIT (Université Internationale de Tunisie) - Campus Cameroun',
      'location': 'Yaoundé',
      'programs': ['Développement d\'Applications Mobiles'],
      'image': 'assets/uit.jpg',
      'rating': 4.1,
      'admissionType': 'Dossier',
      'admissionDetails': 'Sélection sur dossier académique',
      'fees': '500 000 - 2 000 000 FCFA/an',
      'scholarship': 'Bourses internationales et facilités de paiement',
      'website': 'www.uit-tunisie.cm',
    },
    {
      'name': 'Institut Universitaire de la Côte',
      'location': 'Douala',
      'programs': ['Programmation Mobile', 'Technologies Emergentes'],
      'image': 'assets/iuc.jpg',
      'rating': 4.0,
      'admissionType': 'Baccalauréat',
      'admissionDetails': 'Admission directe avec baccalauréat scientifique',
      'fees': '250 000 - 900 000 FCFA/an',
      'scholarship': 'Bourses aux étudiants nécessiteux',
      'website': 'www.iuc-douala.cm',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' universite de Programmation Mobile '),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _universities.length,
        itemBuilder: (context, index) {
          final university = _universities[index];
          return _buildUniversityCard(university, context);
        },
      ),
    );
  }

  Widget _buildUniversityCard(Map<String, dynamic> university, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec nom et localisation
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image de l'université
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.school,
                    color: Colors.green[700],
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        university['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey[600],
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            university['location'],
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Note/rating
                Column(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    Text(
                      university['rating'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Type d'admission avec badge coloré
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getAdmissionColor(university['admissionType']),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Admission: ${university['admissionType']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Information sur les frais
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: Colors.green[700],
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Frais: ${university['fees']}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Programmes proposés
            const Text(
              'Programmes en programmation mobile:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (university['programs'] as List<String>)
                  .map((program) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.green[700],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        program,
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Bouton d'action
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showUniversityDetails(context, university);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Voir les détails complets'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour déterminer la couleur selon le type d'admission
  Color _getAdmissionColor(String admissionType) {
    switch (admissionType) {
      case 'Concours':
        return Colors.red[400]!;
      case 'Dossier + Concours':
        return Colors.orange[400]!;
      case 'Dossier + Entretien':
        return Colors.blue[400]!;
      case 'Dossier + Test':
        return Colors.purple[400]!;
      case 'Entretien':
        return Colors.teal[400]!;
      case 'Baccalauréat':
        return Colors.green[400]!;
      case 'Dossier':
        return Colors.indigo[400]!;
      default:
        return Colors.grey[400]!;
    }
  }

  void _showUniversityDetails(BuildContext context, Map<String, dynamic> university) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(university['name']),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              // Section Admission
              _buildDetailSection(
                title: 'Admission',
                icon: Icons.how_to_reg,
                children: [
                  Text('Type: ${university['admissionType']}'),
                  const SizedBox(height: 8),
                  Text('Détails: ${university['admissionDetails']}'),
                ],
              ),

              const SizedBox(height: 16),

              // Section Financement
              _buildDetailSection(
                title: 'Financement',
                icon: Icons.attach_money,
                children: [
                  Text('Frais de scolarité: ${university['fees']}'),
                  const SizedBox(height: 8),
                  Text('Bourses: ${university['scholarship']}'),
                ],
              ),

              const SizedBox(height: 16),

              // Section Programmes
              _buildDetailSection(
                title: 'Programmes offerts',
                icon: Icons.school,
                children: [
                  ...(university['programs'] as List<String>)
                      .map((program) => Text('• $program'))
                      .toList(),
                ],
              ),

              const SizedBox(height: 16),

              // Section Contact
              _buildDetailSection(
                title: 'Contact',
                icon: Icons.public,
                children: [
                  Text('Site web: ${university['website']}'),
                  const SizedBox(height: 8),
                  Text('Localisation: ${university['location']}'),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.green[700], size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }
}