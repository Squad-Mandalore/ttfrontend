import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/pages/aufgaben/util/task_filter.dart';
import 'package:ttfrontend/pages/aufgaben/util/task_popup_logic.dart';
import 'package:ttfrontend/service/models/task.dart';
import 'package:ttfrontend/service/task_service.dart';

class TaskList extends StatefulWidget {
  final List<Task> tasks;

  final String searchQuery;
  const TaskList({super.key, required this.tasks, required this.searchQuery});

  @override
  State<TaskList> createState() => _TaskListState();
}

class TaskPage extends StatefulWidget {
  final String searchQuery;

  const TaskPage({
    super.key,
    required this.searchQuery,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskListState extends State<TaskList> {
  List<Task> filteredTasks = [];
  bool _showTopShadow = false;
  bool _showBottomShadow = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();
    const double globalPadding = 16.0;

    return Scaffold(
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification) {
                _updateShadows(scrollNotification.metrics);
              }
              return true;
            },
            child: ListView.builder(
              itemCount:
                  filteredTasks.length + 1, // +1 for the addButton on top
              padding: const EdgeInsets.symmetric(
                  horizontal: globalPadding, vertical: globalPadding),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _addButton(theme);
                }

                final task = filteredTasks[index - 1]; // Adjust index for tasks

                return _taskListItem(theme, customColors, task);
              },
            ),
          ),
          if (_showTopShadow)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _shadow(),
            ),
          if (_showBottomShadow)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _shadow(),
            ),
          _floatingAddButton(),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(TaskList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery) {
      _filterTasks();
    }
  }

  @override
  void initState() {
    super.initState();
    _filterTasks();
  }

  Padding _addButton(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          TaskPopupLogic.showAddTaskPopup(context, (newTaskName) async {
            var toAdd = await createTask(newTaskName);
            if (toAdd != null) {
              setState(() {
                widget.tasks.add(toAdd);
                _filterTasks();
              });
            }
          });
        },
        child: DottedBorder(
          color: theme.colorScheme.onSurface,
          strokeWidth: 2,
          borderType: BorderType.RRect,
          radius: const Radius.circular(8),
          dashPattern: const [20, 15],
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: theme.colorScheme.onSurface,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _filterTasks() {
    setState(() {
      filteredTasks = TaskFilter.filterTasks(widget.tasks, widget.searchQuery);
    });
  }

  Positioned _floatingAddButton() {
    return Positioned(
      bottom: 10,
      right: 10,
      child: FloatingActionButton(
        onPressed: () {
          TaskPopupLogic.showAddTaskPopup(context, (newTaskName) async {
            var toAdd = await createTask(newTaskName);
            if (toAdd != null) {
              setState(() {
                widget.tasks.add(toAdd);
                _filterTasks();
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Null Function() _onPressedDelete(Task task) {
    return () {
      TaskPopupLogic.showDeleteConfirmation(context, task, () async {
        var toRemove = await removeTask(task.id);
        if (toRemove != null) {
          setState(() {
            widget.tasks.remove(task);
            _filterTasks();
          });
        }
      });
    };
  }

  Null Function() _onPressedEdit(Task task) {
    return () {
      TaskPopupLogic.showEditTaskPopup(context, task, (newTaskName) async {
        var toUpdate = await updateTask(task.id, newTaskName);
        if (toUpdate != null) {
          setState(() {
            task.name = newTaskName;
            _filterTasks();
          });
        }
      });
    };
  }

  Container _shadow() {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.2),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Row _taskButtons(ThemeData theme, Task task) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.error,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: _textButton(
                theme, task, Icons.delete, 'Löschen', _onPressedDelete(task)),
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(8),
            ),
          ),
          child: _textButton(
              theme, task, Icons.edit, 'Bearbeiten', _onPressedEdit(task)),
        )),
      ],
    );
  }

  Padding _taskListItem(
      ThemeData theme, CustomThemeExtension? customColors, Task task) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: customColors?.primaryAccent8 ?? theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(children: [
          ListTile(
            title: Text(
              task.name,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _taskButtons(theme, task)
        ]),
      ),
    );
  }

  TextButton _textButton(ThemeData theme, Task task, IconData icon, String text,
      Null Function() onPressed) {
    return TextButton.icon(
      icon: Icon(
        icon,
        color: theme.colorScheme.onSecondary,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: theme.colorScheme.onSecondary,
        ),
      ),
      onPressed: onPressed,
    );
  }

  void _updateShadows(ScrollMetrics metrics) {
    setState(() {
      _showTopShadow = metrics.pixels > 0;
      _showBottomShadow = metrics.pixels < metrics.maxScrollExtent;
    });
  }
}

class _TaskPageState extends State<TaskPage> {
  late Future<List<Task>> tasksFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: tasksFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          return TaskList(
              tasks: snapshot.data!, searchQuery: widget.searchQuery);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    tasksFuture = fetchTasks();
  }
}
