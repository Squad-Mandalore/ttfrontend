import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ttfrontend/pages/tasks/util/task_filter.dart';
import 'package:ttfrontend/pages/tasks/util/task_popup_logic.dart';

class Task {
  final int id;
  String name;

  Task({required this.id, required this.name});
}

class TaskPage extends StatefulWidget {
  final List<Task> tasks;
  final String searchQuery;

  const TaskPage({
    super.key,
    required this.tasks,
    required this.searchQuery,
  });

  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  List<Task> filteredTasks = [];
  bool _showTopShadow = false;
  bool _showBottomShadow = false;

  @override
  void initState() {
    super.initState();
    _filterTasks();
  }

  @override
  void didUpdateWidget(TaskPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery) {
      _filterTasks();
    }
  }

  void _filterTasks() {
    setState(() {
      filteredTasks = TaskFilter.filterTasks(widget.tasks, widget.searchQuery);
    });
  }

  void _updateShadows(ScrollMetrics metrics) {
    setState(() {
      _showTopShadow = metrics.pixels > 0;
      _showBottomShadow = metrics.pixels < metrics.maxScrollExtent;
    });
  }

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
              itemCount: filteredTasks.length + 2, // +2 for the top and bottom spacing
              padding: const EdgeInsets.symmetric(horizontal: globalPadding),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox(height: globalPadding); // Top spacing
                }
                if (index == filteredTasks.length + 1) {
                  return const SizedBox(height: globalPadding); // Bottom spacing
                }

                if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        TaskPopupLogic.showAddTaskPopup(context, (newTaskName) {
                          setState(() {
                            final newTask = Task(
                                id: 2,
                                name: newTaskName);
                            widget.tasks.add(newTask);
                            _filterTasks();
                          });
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

                final task = filteredTasks[index - 2]; // Adjust index for tasks

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: customColors?.primaryAccent8 ??
                          theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
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
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.error,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                                child: TextButton.icon(
                                  icon: Icon(
                                    Icons.delete,
                                    color: theme.colorScheme.onError,
                                  ),
                                  label: Text(
                                    'Löschen',
                                    style: TextStyle(
                                      color: theme.colorScheme.onError,
                                    ),
                                  ),
                                  onPressed: () {
                                    TaskPopupLogic.showDeleteConfirmation(
                                        context, task, () {
                                      setState(() {
                                        widget.tasks.remove(task);
                                        _filterTasks();
                                      });
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                ),
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
                                child: TextButton.icon(
                                  icon: Icon(
                                    Icons.edit,
                                    color: theme.colorScheme.onSecondary,
                                  ),
                                  label: Text(
                                    'Bearbeiten',
                                    style: TextStyle(
                                      color: theme.colorScheme.onSecondary,
                                    ),
                                  ),
                                  onPressed: () {
                                    TaskPopupLogic.showEditTaskPopup(
                                        context, task, (newTaskName) {
                                      setState(() {
                                        task.name = newTaskName;
                                        _filterTasks();
                                      });
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_showTopShadow)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          if (_showBottomShadow)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
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
              ),
            ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {
                TaskPopupLogic.showAddTaskPopup(context, (newTaskName) {
                  setState(() {
                    final newTask = Task(
                        id: 2, name: newTaskName);
                    widget.tasks.add(newTask);
                    _filterTasks();
                  });
                });
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
