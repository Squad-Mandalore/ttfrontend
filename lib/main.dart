import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/theme.dart';
import 'package:ttfrontend/pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squad Mandalore Zeitmessung',
      theme: AppTheme.lightBaumarktRot(), // Set light theme
      darkTheme: AppTheme.lightBaumarktRot(), // Set dark theme
      themeMode: ThemeMode.system, // Use system theme by default
      home: const LoginPage(), // Initial Page
    );
  }
}
