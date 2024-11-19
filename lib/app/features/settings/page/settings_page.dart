import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/cubit/root_cubit.dart';
import 'package:todo/app/features/widgets/my_app_bar.dart';
import 'package:todo/app/features/widgets/my_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RootCubit(),
        child: BlocBuilder<RootCubit, RootState>(
          builder: (context, state) {
            return Scaffold(
              appBar: const MyAppBar(title: 'Settings'),
              drawer: const MyDrawer(),
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign out:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<RootCubit>().signOut();
                          },
                          icon: const Icon(Icons.logout),
                          color: Theme.of(context).colorScheme.onSurface,
                          iconSize: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
