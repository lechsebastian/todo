import 'package:flutter/material.dart';
import 'package:todo/app/cubit/root_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/features/widgets/my_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
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
