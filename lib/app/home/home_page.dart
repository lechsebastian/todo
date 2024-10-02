import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todo/app/home/settings/settings_page_content.dart';
import 'package:todo/app/home/tasks/tasks_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: currentIndex == 0
            ? const Text(
                'To do',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : null,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const TasksPageContent();
        }
        return SettingsPageContent(email: widget.user.email!);
      }),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.all(16),
            gap: 8,
            onTabChange: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.assignment,
                text: 'Tasks',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
class NewWidget extends StatefulWidget {
  const NewWidget({
    super.key,
  });

  final Function

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          padding: const EdgeInsets.all(16),
          gap: 8,
          onTabChange: (value) {
            
          },
          tabs: const [
            GButton(
              icon: Icons.assignment,
              text: 'Tasks',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
*/
