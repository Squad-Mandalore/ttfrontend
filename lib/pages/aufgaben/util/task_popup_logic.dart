import 'package:flutter/material.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';
import 'package:ttfrontend/pages/aufgaben/tasks.dart'; // Assuming Task is defined here

class TaskPopupLogic {
  static void showDeleteConfirmation(
      BuildContext context, Task task, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericPopup(
          title: 'Aufgabe löschen',
          agreeText: 'Löschen',
          content: Column(
            children: [
              Text("Möchten Sie die Aufgabe ${task.name} wirklich löschen?"),
              const Text(
                  "Änderungen sind global und betreffen somit alle Benutzer."),
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
              const Text(
                  "Änderungen sind global und für alle Benutzer sichtbar."),
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
