import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/cubit/root_cubit.dart';
import 'package:todo/app/features/tasks/pages/tasks_page.dart';
import 'package:todo/app/features/login/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:todo/theme/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit()..start(),
      child: BlocConsumer<RootCubit, RootState>(
        listenWhen: (previous, current) {
          return previous.user != current.user;
        },
        listener: (context, state) {
          if (state.user == null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const RootPage(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text('Something went wrong. Error: ${state.errorMessage}'),
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
          final user = state.user;

          if (user == null) {
            return LoginPage();
          }
          return const TasksPage();
        },
      ),
    );
  }
}
