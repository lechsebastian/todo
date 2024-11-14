import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/app.dart';
import 'package:todo/theme/theme_provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}
