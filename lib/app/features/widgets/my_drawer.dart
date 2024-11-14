import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/features/notes/page/notes_page.dart';
import 'package:todo/app/features/settings/cubit/settings_cubit.dart';
import 'package:todo/app/features/settings/page/settings_page.dart';
import 'package:todo/app/features/tasks/page/tasks_page.dart';
import 'package:todo/theme/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.assignment,
                size: 100,
              ),
            ),
            Column(
              children: [
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const NotesPage()));
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
          ],
        ),
      ),
    );
  }
}
