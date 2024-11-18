import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/cubit/root_cubit.dart';
import 'package:todo/app/features/login/login_page.dart';
import 'package:todo/app/features/settings/cubit/settings_cubit.dart';
import 'package:todo/app/features/widgets/my_app_bar.dart';
import 'package:todo/app/features/widgets/my_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Settings'),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocProvider(
        create: (context) => SettingsCubit(),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state.isSignedOut) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: context.read<RootCubit>(),
                      child: LoginPage(),
                    ),
                  ),
                );
              });
            }

            if (state.errorMessage.isNotEmpty) {
              return Center(
                child:
                    Text('Something went wrong. Error: ${state.errorMessage}'),
              );
            }

            if (state.isLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 5),
                    Text('Loading..'),
                  ],
                ),
              );
            }

            return Padding(
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
                          context.read<SettingsCubit>().signOut();
                        },
                        icon: const Icon(Icons.logout),
                        color: Theme.of(context).colorScheme.onSurface,
                        iconSize: 30,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
