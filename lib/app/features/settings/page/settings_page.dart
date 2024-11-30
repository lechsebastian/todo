import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/cubit/root_cubit.dart';
import 'package:todo/app/features/common/widgets/my_app_bar.dart';
import 'package:todo/theme/theme_provider.dart';

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
              appBar: MyAppBar(
                title: 'Settings',
                actions: [
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
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Dark mode:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Provider.of<ThemeProvider>(context, listen: false)
                                    .isDarkMode
                                ? Icons.light_mode
                                : Icons.dark_mode,
                          ),
                          onPressed: () {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
