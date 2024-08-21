import 'package:flutter/material.dart';
import 'package:ttfrontend/pages/timer/widgets/task_selection_popup.dart';

class AufgabenButton extends StatefulWidget {
  final Function(String) onTaskSelected;
  final String? initialTask;

  const AufgabenButton({
    super.key,
    required this.onTaskSelected,
    this.initialTask,
  });

  @override
  AufgabenButtonState createState() => AufgabenButtonState();
}

class AufgabenButtonState extends State<AufgabenButton> {
  String _selectedTask = "Aufgabe auswählen"; // Default text
  bool _isPopupOpen = false; // Track if the popup is open

  @override
  void initState() {
    super.initState();
    if (widget.initialTask != null) {
      _selectedTask = widget.initialTask!; // Set the initial task if present
    }
  }

  // This is called whenever the widget is rebuilt with new properties.
  @override
  void didUpdateWidget(AufgabenButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTask != oldWidget.initialTask &&
        widget.initialTask != null) {
      setState(() {
        _selectedTask = widget.initialTask!;
      });
    }
  }

  void _openTaskSelectionPopup(BuildContext context) async {
    setState(() {
      _isPopupOpen = true; // Set popup open state
    });

    final selectedTask = await showDialog<String>(
      context: context,
      builder: (context) {
        return TaskSelectionPopup(
          onTaskSelected: (task) {
            Navigator.of(context).pop(task);
          },
        );
      },
    );

    setState(() {
      _isPopupOpen = false; // Set popup closed state
    });

    // Update the selected task when a task is chosen
    if (selectedTask != null) {
      setState(() {
        _selectedTask = selectedTask;
      });

      // Trigger the callback to notify about the task change
      widget.onTaskSelected(selectedTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: () => _openTaskSelectionPopup(context),
        height: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedTask,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            AnimatedRotation(
              turns: _isPopupOpen ? 0.5 : 0.0, // Rotate 180 degrees when open
              duration: const Duration(milliseconds: 200),
              curve: Easing.emphasizedDecelerate,
              child: const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
