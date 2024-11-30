import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    required this.title,
    this.actions,
    super.key,
  });

  final String title;
  final List<Widget>? actions;

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
      actions: actions,
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
