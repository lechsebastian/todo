import 'package:flutter/material.dart';
import 'package:todo/app/features/notes/pages/notes_page.dart';
import 'package:todo/app/features/settings/page/settings_page.dart';
import 'package:todo/app/features/tasks/pages/tasks_page.dart';

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
                    Navigator.pop(context);
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
                    Navigator.of(context).push(MaterialPageRoute(
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
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
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