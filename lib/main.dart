// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ttfrontend/pages/login/login.dart';
import 'package:ttfrontend/pages/theme_selection/theme_provider/theme_provider.dart';
import 'package:ttfrontend/pages/timer/timer_logic.dart';
import 'package:ttfrontend/service/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the app orientation to portrait modes
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize ThemeProvider and load saved preferences
  ThemeProvider themeProvider = ThemeProvider();
  await themeProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => themeProvider,
        ),
        ChangeNotifierProvider<TimerLogic>(
          create: (context) => TimerLogic(), // Timer is now available everywhere
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to ThemeProvider for theme changes
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Squad Mandalore Zeitmessung',
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      navigatorKey: NavigationService.navigatorKey,
      home: const LoginPage(),
      debugShowCheckedModeBanner: false, // Optional: Remove debug banner
    );
  }
}
