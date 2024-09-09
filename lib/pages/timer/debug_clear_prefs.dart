import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DebugClearPrefsButton extends StatelessWidget {
  const DebugClearPrefsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Shared preferences cleared!')),
          );
        }
      },
      child: const Text('Clear Shared Preferences'),
    );
  }
}
