import 'package:flutter/material.dart';
import 'package:todo/app/cubit/root_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              context.read<RootCubit>().signOut();
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
