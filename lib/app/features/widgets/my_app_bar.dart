import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/theme/theme_provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      actions: [
        IconButton(
          icon: Icon(
            Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
