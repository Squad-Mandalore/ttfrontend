import 'package:flutter/material.dart';
import 'package:ttfrontend/pages/aufgaben/task_list.dart';
import 'package:ttfrontend/pages/aufgaben/util/task_popup_logic.dart';
import 'package:ttfrontend/service/models/task.dart';
import 'package:ttfrontend/service/task_service.dart';

class TaskPage extends StatefulWidget {
  final String searchQuery;

  const TaskPage({
    super.key,
    required this.searchQuery,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late Future<List<Task>> tasksFuture;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    setState(() {
      tasksFuture = fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: tasksFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Es ist ein Fehler aufgetreten!'),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return _buildEmptyTaskView(context);
          } else {
            return TaskList(
              tasks: snapshot.data!, 
              searchQuery: widget.searchQuery,
              onTaskListUpdated: _loadTasks,
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildEmptyTaskView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'Keine Aufgaben gefunden.\nFüge eine neue Aufgabe hinzu!',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              TaskPopupLogic.showAddTaskPopup(context, (newTaskName) async {
                var toAdd = await createTask(newTaskName);
                if (toAdd != null) {
                  _loadTasks();  // Reload the tasks after adding a new task
                }
              });
            },
            child: const Text('Neue Aufgabe hinzufügen'),
          ),
        ],
      ),
    );
  }
}
