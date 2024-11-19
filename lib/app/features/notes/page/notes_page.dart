import 'package:flutter/material.dart';
import 'package:todo/app/features/widgets/my_app_bar.dart';
import 'package:todo/app/features/widgets/my_drawer.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Notes'),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: const Center(
        child: Text('Notes Page'),
      ),
    );
  }
}
