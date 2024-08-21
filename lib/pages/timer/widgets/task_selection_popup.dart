import 'package:flutter/material.dart';

class TaskSelectionPopup extends StatelessWidget {
  final Function(String) onTaskSelected;

  const TaskSelectionPopup({
    super.key,
    required this.onTaskSelected,
  });

  //TODO: Make good

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Aufgabe auswählen',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Task 1'),
              onTap: () => onTaskSelected('Task 1'),
            ),
            ListTile(
              title: const Text('Task 2'),
              onTap: () => onTaskSelected('Task 2'),
            ),
            ListTile(
              title: const Text('Task 3'),
              onTap: () => onTaskSelected('Task 3'),
            ),
          ],
        ),
      ),
    );
  }
}
