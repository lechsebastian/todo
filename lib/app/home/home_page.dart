import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You are signed in as ${user.email}'),
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
      ),
    );
  }
}
