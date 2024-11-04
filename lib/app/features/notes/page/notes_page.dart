import 'package:flutter/material.dart';
import 'package:todo/app/features/widgets/my_drawer.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade300,
      ),
      drawer: const MyDrawer(),
      backgroundColor: Colors.grey.shade300,
      body: const Center(
        child: Text('Notes Page'),
      ),
    );
  }
}
