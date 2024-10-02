import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPageContent extends StatelessWidget {
  const SettingsPageContent({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You are signed in as $email'),
          const SizedBox(height: 20),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
            color: Colors.black,
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}