import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/widgets/my_textfield.dart';

class MyAddTaskDialog extends StatefulWidget {
  const MyAddTaskDialog({super.key});

  @override
  _MyAddTaskDialogState createState() => _MyAddTaskDialogState();
}

class _MyAddTaskDialogState extends State<MyAddTaskDialog> {
  int _selectedPriority = 1;
  final taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('tasks').add({
                  'name': taskController.text,
                  'priority': _selectedPriority,
                  'done': false,
                });
                Navigator.of(context).pop();
                taskController.clear();
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        )
      ],
      title: const Text('New task'),
      content: Container(
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextField(
              controller: taskController,
              label: 'Name',
              isObscure: false,
            ),
            const SizedBox(height: 10),
            const Text('Priority:'),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                    const Text('High'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: _selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                    const Text('Medium'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: _selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                    const Text('Low'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
