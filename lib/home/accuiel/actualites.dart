import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Actualites extends StatefulWidget {
  const Actualites({super.key});

  @override
  State<Actualites> createState() => _AcualitesState();
}

class _AcualitesState extends State<Actualites> {
  final List<NewsItem> _newsItems = [
    NewsItem(
      title: 'Concours ENS 2024',
      description: 'Concours d\'entrée à l\'École Normale Supérieure. Date limite: 15 Décembre 2024',
      type: 'Concours',
      date: DateTime(2025, 7, 15),
      category: 'Enseignement',
    ),
    NewsItem(
      title: 'Bourse d\'excellence',
      description: 'Bourse pour étudiants méritants. Montant: 500 000 FCFA par an',
      type: 'Bourse',
      date: DateTime(2025, 11, 10),
      category: 'Financement',
    ),
    NewsItem(
      title: 'Concours Polytechnique',
      description: 'Concours d\'entrée aux écoles d\'ingénieurs. Inscriptions ouvertes',
      type: 'Concours',
      date: DateTime(2025, 10, 30),
      category: 'Ingénierie',
    ),
    NewsItem(
      title: 'Concours ENSTP',
      description: 'Concours d\'entre a l\'ecole superieur travux publics',
      type: 'Concours',
      date: DateTime(2025, 9, 10),
      category: 'Ingenierie',
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedType = 'Concours';

  void _addNewsItem() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      setState(() {
        _newsItems.add(NewsItem(
          title: _titleController.text,
          description: _descriptionController.text,
          type: _selectedType,
          date: _selectedDate!,
          category: _categoryController.text,
        ));

        // Réinitialiser le formulaire
        _titleController.clear();
        _descriptionController.clear();
        _categoryController.clear();
        _selectedDate = null;
        _selectedType = 'Concours';
      });

      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('fr', 'FR'),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter une actualité'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Titre',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un titre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Catégorie',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une catégorie';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Concours', 'Bourse'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        border: OutlineInputBorder(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate != null
                                ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                                : 'Sélectionner une date',
                          ),
                          const Icon(Icons.calendar_month),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: _addNewsItem,
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualités '),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: _newsItems.isEmpty
          ? const Center(
        child: Text(
          'Aucune actualité pour le moment',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _newsItems.length,
        itemBuilder: (context, index) {
          final news = _newsItems[index];
          return _buildNewsCard(news);
        },
      ),
    );
  }

  Widget _buildNewsCard(NewsItem news) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    news.type,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: news.type == 'Concours' ? Colors.orangeAccent : Colors.blue,
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(news.date),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              news.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              news.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Catégorie: ${news.category}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,

              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsItem {
  final String title;
  final String description;
  final String type;
  final DateTime date;
  final String category;


  NewsItem({
    required this.title,
    required this.description,
    required this.type,
    required this.date,
    required this.category,
  });
}