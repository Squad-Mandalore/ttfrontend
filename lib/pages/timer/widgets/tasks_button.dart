import 'package:flutter/material.dart';
import 'package:ttfrontend/service/models/task.dart';

class TasksButton extends StatefulWidget {
  final Function(Task) onTaskSelected;
  final Task? initialTask;
  final List<Task> availableTasks;

  const TasksButton({
    Key? key,
    required this.onTaskSelected,
    this.initialTask,
    required this.availableTasks,
  }) : super(key: key);

  @override
  TasksButtonState createState() => TasksButtonState();
}

class TasksButtonState extends State<TasksButton> {
  Task? _selectedTask;

  @override
  void initState() {
    super.initState();
    _selectedTask = widget.initialTask;
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

    return DropdownButtonFormField<Task>(
      value: _selectedTask,
      decoration: const InputDecoration(
        labelText: 'Aufgabe auswählen',
        border: OutlineInputBorder(),
      ),
      items: widget.availableTasks
          .map(
            (task) => DropdownMenuItem<Task>(
              value: task,
              child: Text(task.name),
            ),
          )
          .toList(),
      onChanged: (Task? newTask) {
        if (newTask != null) {
          setState(() {
            _selectedTask = newTask;
          });
          widget.onTaskSelected(newTask);
        }
      },
      isExpanded: true,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      dropdownColor: theme.colorScheme.surface,
    );
  }
}
