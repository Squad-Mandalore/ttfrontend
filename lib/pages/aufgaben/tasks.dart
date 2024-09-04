import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';
import 'package:ttfrontend/pages/aufgaben/util/task_filter.dart';

class Task {
  final String id;
  final String name;

  Task({required this.id, required this.name});
}

class TaskPage extends StatefulWidget {
  final List<Task> tasks;
  final String searchQuery; // Add searchQuery as a parameter

  const TaskPage({
    super.key,
    required this.tasks,
    required this.searchQuery, // Initialize with searchQuery
  });

  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  List<Task> filteredTasks = [];

  @override
  void initState() {
    super.initState();
    _filterTasks(); // Call the filter function on init
  }

  @override
  void didUpdateWidget(TaskPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery) {
      _filterTasks(); // Re-filter tasks if the search query changes
    }
  }

  void _filterTasks() {
    setState(() {
      filteredTasks = TaskFilter.filterTasks(widget.tasks, widget.searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();
    const double globalPadding = 16.0;

    return Scaffold(
      body: filteredTasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Keine Aufgaben verfügbar',
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      surfaceTintColor: theme.colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      _showAddTaskPopup(context);
                    },
                    child: Text(
                      'Neue Aufgabe hinzufügen',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(globalPadding),
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: filteredTasks.length + 1,
                    itemBuilder: (context, index) {
                      if (index == filteredTasks.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              _showAddTaskPopup(context);
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

                      final task = filteredTasks[index];

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
                              Divider(
                                height: 1,
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.5),
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
                                          _showDeleteConfirmation(
                                              context, task);
                                        },
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton.icon(
                                      icon: Icon(
                                        Icons.edit,
                                        color: theme.colorScheme.primary,
                                      ),
                                      label: Text(
                                        'Bearbeiten',
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                      onPressed: () {
                                        _showEditTaskPopup(context, task);
                                      },
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
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: () {
                        _showAddTaskPopup(context);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
    );
  }



  void _showDeleteConfirmation(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericPopup(
          title: 'Aufgabe löschen',
          content: Column(
            children: [
              Text("Möchten Sie die Aufgabe ${task.name} wirklich löschen?"),
              const Text(
                  "Änderungen sind global und betreffen somit alle Benutzer."),
            ],
          ),
          mode: PopUpMode.warning,
          onAgree: () {
            // Delete task logic using task.id
            Navigator.of(context).pop();
          },
          onDisagree: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showEditTaskPopup(BuildContext context, Task task) {
    final TextEditingController controller =
        TextEditingController(text: task.name);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericPopup(
          title: 'Aufgabe bearbeiten',
          content: Column(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: task.name,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                  "Änderungen sind global und für alle Benutzer sichtbar."),
            ],
          ),
          mode: PopUpMode.agree,
          onAgree: () {
            // Edit task logic using task.id and controller.text
            Navigator.of(context).pop();
          },
          onDisagree: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showAddTaskPopup(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericPopup(
          title: 'Neue Aufgabe hinzufügen',
          content: Column(
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: "Neue Aufgabe",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                  "Die neue Aufgabe wird global hinzugefügt und ist für alle Benutzer sichtbar."),
            ],
          ),
          mode: PopUpMode.agree,
          onAgree: () {
            // Add task logic using controller.text
            Navigator.of(context).pop();
          },
          onDisagree: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

}