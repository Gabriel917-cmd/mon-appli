import 'package:flutter/material.dart';
import 'package:mon_appli/compoments/task_card.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({
    required this.username,
    super.key
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> tasks = [
    {"title": "faire les courses", "description":"acheter du pain au lait"},
    {"title": "reviser flutter ", "description": "setState, ListView, SQfLite"},
    {"title": " supporter barcelone ", "description": " yamal, pedri, gavi "},
  ];

  void _goToAddTask () {

  }
  void _editTask(int index){

  }
  void _deleteTask(int index){
    setState(() {
      tasks.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("bienvenue ${widget.username}"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _goToAddTask,
            ),
          ]
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: tasks.asMap().entries.map((entry) {
          int i = entry.key;
          var task = entry.value;
          return TaskCard (
            title: task["title"] ?? '',
            description: task["description"] ??'',
            onEdit: () => _editTask(i),
            onDelete: ()=> _deleteTask(i),
          );
        }).toList(),
      ),
    );
  }
}

