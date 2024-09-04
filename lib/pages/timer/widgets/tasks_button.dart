import 'package:flutter/material.dart';
import 'package:ttfrontend/pages/timer/widgets/task_selection_popup.dart';

class TasksButton extends StatefulWidget {
  final Function(String) onTaskSelected;
  final String? initialTask;
  final List<String> tasks;

  const TasksButton({
    super.key,
    required this.onTaskSelected,
    required this.tasks,
    this.initialTask,
  });

  @override
  TasksButtonState createState() => TasksButtonState();
}

class TasksButtonState extends State<TasksButton> {
  String _selectedTask = "Aufgabe auswählen";
  bool _isPopupOpen = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialTask != null) {
      _selectedTask = widget.initialTask!;
    }
  }

  @override
  void didUpdateWidget(TasksButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTask != oldWidget.initialTask &&
        widget.initialTask != null) {
      setState(() {
        _selectedTask = widget.initialTask!;
      });
    }
  }

  void _openTaskSelectionPopup(BuildContext context) {
    setState(() {
      _isPopupOpen = true;
    });

    showDialog(
      context: context,
      builder: (context) {
        return TaskSelectionPopup(
          tasks: widget.tasks,
          onTaskSelected: (task) {
            // Call the task selected callback and close the popup.
            setState(() {
              _selectedTask = task;
              widget.onTaskSelected(task);
              _isPopupOpen = false;
            });
            Navigator.of(context).pop(); // Close the popup manually.
          },
        );
      },
    );
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
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final availableWidth =
                      constraints.maxWidth - 40; // Reserve space for the icon
                  String displayText = _selectedTask;

                  final TextPainter textPainter = TextPainter(
                    text: TextSpan(
                      text: displayText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                  )..layout(maxWidth: availableWidth);

                  if (textPainter.didExceedMaxLines) {
                    // Truncate text based on available width
                    final int cutoff = textPainter
                        .getPositionForOffset(Offset(availableWidth, 0))
                        .offset;
                    displayText = '${_selectedTask.substring(0, cutoff)}...';
                  }

                  return Text(
                    displayText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
            AnimatedRotation(
              turns: _isPopupOpen ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
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
