import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todo/app/cubit/root_cubit.dart';
import 'package:todo/app/features/home/settings/settings_page_content.dart';
import 'package:todo/app/features/home/tasks/tasks_page_content.dart';
import 'package:todo/app/features/widgets/my_add_task_dialog.dart';

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
    return BlocProvider(
      create: (context) => RootCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          title: currentIndex == 0
              ? const Text(
                  'TO DO',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              : null,
          centerTitle: true,
        ),
        backgroundColor: Colors.grey.shade300,
        body: Builder(
          builder: (context) {
            if (currentIndex == 0) {
              return const TasksPageContent();
            }
            return SettingsPageContent(email: widget.user.email!);
          },
        ),
        floatingActionButton: currentIndex == 0
            ? FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (dialogContext) => BlocProvider.value(
                      value: context.read<RootCubit>(),
                      child: const MyAddTaskDialog(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : null,
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
      ),
    );
  }
}
