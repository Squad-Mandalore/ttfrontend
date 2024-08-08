import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/colours.dart';
import 'package:ttfrontend/pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColours.bgDark,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'ntn',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      home: const LoginPage(), // initial Page
    );
  }
}
