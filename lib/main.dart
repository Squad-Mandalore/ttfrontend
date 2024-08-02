import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/colours.dart';
import 'package:ttfrontend/pages/login.dart'; // Ensure you import the correct file for LoginPage

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
        scaffoldBackgroundColor: AppColours.bgDark, // Correct parameter for background color
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'ntn',
            fontWeight: FontWeight.w500,
            color: Colors.white, // Universal text color
          ),
        ),
      ),
      home: const LoginPage(), // Set your initial page
    );
  }
}
