import 'package:flutter/material.dart';
import 'package:ttfrontend/pages/timer/widgets/task_selection_popup.dart';
import 'package:ttfrontend/service/models/task.dart';
import 'package:ttfrontend/service/task_service.dart';

class TasksButtonOld extends StatefulWidget {
  final Function(Task) onTaskSelected;
  final Task? initialTask;

  const TasksButtonOld({
    super.key,
    required this.onTaskSelected,
    this.initialTask,
  });

  @override
  TasksButtonOldState createState() => TasksButtonOldState();
}

class TasksButtonOldState extends State<TasksButtonOld> {
  Task? _selectedTask;
  bool _isPopupOpen = false;
  late Future<List<Task>> tasksFuture;

  @override
  void initState() {
    super.initState();
    tasksFuture = fetchTasks();
    if (widget.initialTask != null) {
      _selectedTask = widget.initialTask!;
    }
  }

  @override
  void didUpdateWidget(TasksButtonOld oldWidget) {
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
        return FutureBuilder<List<Task>>(
          future: tasksFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              return TaskSelectionPopup(
                tasks: snapshot.data!,
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
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
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
                  String displayText = _selectedTask == null
                      ? "Aufgabe auswählen"
                      : _selectedTask!.name;

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
                    displayText =
                        '${_selectedTask!.name.substring(0, cutoff)}...';
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
