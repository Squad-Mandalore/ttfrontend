import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/pages/timer/widgets/task_selection_popup.dart';
import 'package:ttfrontend/service/models/task.dart';
import 'package:ttfrontend/service/task_service.dart';

class TasksButton extends StatefulWidget {
  final Function(Task) onTaskSelected;
  final Task? initialTask;

  const TasksButton({
    super.key,
    required this.onTaskSelected,
    this.initialTask,
  });

  @override
  TasksButtonState createState() => TasksButtonState();
}

class TasksButtonState extends State<TasksButton> {
  Task? _selectedTask;
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
  void didUpdateWidget(TasksButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTask != oldWidget.initialTask &&
        widget.initialTask != null) {
      setState(() {
        _selectedTask = widget.initialTask!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    return FutureBuilder<List<Task>>(
      future: tasksFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          final tasks = snapshot.data!;
          final dropdownItems = tasks.map((task) {
            return DropdownMenuItem<Task>(
              value: task,
              child: Text(
                task.name,
                style: const TextStyle(fontSize: 14),
              ),
            );
          }).toList();

          return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: _selectedTask == null
                  ? theme.colorScheme.secondary.withOpacity(0.1) // Highlight color
                  : theme.colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<Task>(
                barrierColor: theme.colorScheme.onSurface.withOpacity(0.1),
                isExpanded: true,
                hint: Text(
                  _selectedTask == null
                      ? "Aufgabe auswählen"
                      : _selectedTask!.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _selectedTask == null
                        ? theme.colorScheme.error // Highlighted color when no task is selected
                        : Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                items: dropdownItems,
                value: _selectedTask,
                onChanged: (task) {
                  if (task != null) {
                    setState(() {
                      _selectedTask = task;
                      widget.onTaskSelected(task);
                    });
                  }
                },
                buttonStyleData: ButtonStyleData(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: customColors?.backgroundAccent3 ??
                        theme.colorScheme.surface,
                    border: Border.all(
                      color: _selectedTask == null
                          ? theme.colorScheme.error // Highlighted border when no task is selected
                          : theme.colorScheme.onSurface.withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
