import 'package:flutter/material.dart';

import 'fiche d\'incription.dart';




class StagePage extends StatelessWidget {
  final Stage stage;

  const StagePage({Key? key, required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stage.titre),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image du stage
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(stage.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Titre du stage
            Text(
              stage.titre,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Entreprise et localisation
            Row(
              children: [
                const Icon(Icons.business, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  stage.entreprise,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 15),
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  stage.localisation,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Description du stage
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(stage.description),
            const SizedBox(height: 20),

            // Compétences requises
            const Text(
              "Compétences requises",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: stage.competences.map((competence) {
                return Chip(
                  label: Text(competence),
                  backgroundColor: Colors.blue[50],
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            // Bouton Postuler
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FicheInscriptionPage(stage: stage),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "POSTULER",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Modèle de données pour un stage
class Stage {
  final String id;
  final String titre;
  final String entreprise;
  final String localisation;
  final String description;
  final String imageUrl;
  final List<String> competences;

  Stage({
    required this.id,
    required this.titre,
    required this.entreprise,
    required this.localisation,
    required this.description,
    required this.imageUrl,
    required this.competences,
  });
}