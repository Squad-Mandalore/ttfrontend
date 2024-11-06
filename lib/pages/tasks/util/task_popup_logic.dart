import 'package:flutter/material.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';
import 'package:ttfrontend/service/models/task.dart'; // Assuming Task is defined here

class TaskPopupLogic {
  static void showDeleteConfirmation(
      BuildContext context, Task task, VoidCallback onDelete) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericPopup(
          title: 'Aufgabe löschen',
          agreeText: 'Löschen',
          content: Column(
            children: [
              Text("Möchten Sie die Aufgabe ${task.name} wirklich löschen?",
                  style: TextStyle(color: theme.colorScheme.onSurface)),
              Text("Änderungen sind global und betreffen somit alle Benutzer.",
                  style: TextStyle(color: theme.colorScheme.onSurface)),
            ],
          ),
          mode: PopUpMode.warning,
          onAgree: () {
            onDelete();
            Navigator.of(context).pop();
          },
          onDisagree: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  static void showEditTaskPopup(
      BuildContext context, Task task, Function(String) onEdit) {
    final TextEditingController controller =
        TextEditingController(text: task.name);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericPopup(
          title: 'Aufgabe bearbeiten',
          agreeText: 'Bearbeiten',
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
              Text("Änderungen sind global und für alle Benutzer sichtbar.",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface)),
            ],
          ),
          mode: PopUpMode.agree,
          onAgree: () {
            onEdit(controller.text);
            Navigator.of(context).pop();
          },
          onDisagree: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  static void showAddTaskPopup(BuildContext context, Function(String) onAdd) {
    final TextEditingController controller = TextEditingController();
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericPopup(
          title: 'Neue Aufgabe hinzufügen',
          agreeText: 'Hinzufügen',
          content: Column(
            children: [
              TextField(
                controller: controller,
                maxLength: 100,
                decoration: const InputDecoration(
                  labelText: "Neue Aufgabe",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Die neue Aufgabe wird global hinzugefügt und ist für alle Benutzer sichtbar.",
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          mode: PopUpMode.agree,
          onAgree: () {
            onAdd(controller.text);
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
