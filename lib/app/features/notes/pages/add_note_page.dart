import 'package:flutter/material.dart';
import 'package:todo/app/features/common/widgets/my_app_bar.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: 'Note'),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text('Add a new note'),
      ),
    );
  }
}
