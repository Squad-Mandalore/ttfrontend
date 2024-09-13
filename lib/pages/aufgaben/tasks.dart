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
        } else if (snapshot.hasData) {
          return TaskList(
            tasks: snapshot.data!,
            searchQuery: widget.searchQuery,
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
