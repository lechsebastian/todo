import 'package:flutter/material.dart';
import 'package:todo/app/cubit/root_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/features/tasks/page/tasks_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SETTINGS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade300,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey.shade300,
          child: ListView(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.assignment,
                  size: 100,
                ),
              ),
              ListTile(
                title: const Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: const Icon(Icons.assignment_turned_in),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const TasksPage()));
                },
              ),
              ListTile(
                title: const Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: const Icon(Icons.sticky_note_2),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: const Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign out'),
            const SizedBox(height: 20),
            IconButton(
              onPressed: () {
                context.read<RootCubit>().signOut();
              },
              icon: const Icon(Icons.logout),
              color: Colors.black,
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}
