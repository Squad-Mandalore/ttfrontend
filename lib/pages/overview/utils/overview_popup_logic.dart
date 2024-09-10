import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';
import 'package:ttfrontend/pages/overview/utils/overview_logic.dart';
import 'package:ttfrontend/pages/tasks/tasks.dart';
import 'package:ttfrontend/pages/timer/widgets/tasks_button.dart';

class OverviewPopupLogic {
  static void showDeleteConfirmation(BuildContext context, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericPopup(
          title: 'Eintrag löschen',
          agreeText: 'Löschen',
          content: const Column(
            children: [
              Text("Möchten Sie die Zeit wirklich löschen?"),
              Text("Diese Aktion kann nicht rückgängig gemacht werden."),
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

  static void showEditPopup(
    BuildContext context,
    TimeEntry entry,
    Function(TimeEntry) onEdit,
    List<Task> availableTasks,  // Pass in the available tasks
  ) {
    final TextEditingController hoursController =
        TextEditingController(text: entry.hours.toString());
    final TextEditingController minutesController =
        TextEditingController(text: entry.minutes.toString());
    final List<String> timeTypes = ['Fahrtzeit', 'Arbeitszeit', 'Pause'];
    String selectedType = entry.type;
    String selectedTask = entry.activity;  // This will store the selected task

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericPopup(
          mode: PopUpMode.agree,
          title: 'Zeit bearbeiten',
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: hoursController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'hh',
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(':'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: minutesController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'mm',
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedType,
                    decoration: const InputDecoration(
                      labelText: 'Typ der Zeit',
                      border: OutlineInputBorder(),
                    ),
                    items: timeTypes
                        .map((type) => DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedType = newValue!;
                        if (selectedType == 'Pause') {
                          selectedTask = 'Neue Aufgabe zuweisen';  // Clear the task if Pause is selected
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  // Conditionally show the TasksButton if the type is not "Pause"
                  if (selectedType != 'Pause')
                    TasksButton(
                      tasks: availableTasks,
                      initialTask: selectedTask,
                      onTaskSelected: (task) {
                        setState(() {
                          selectedTask = task;
                        });
                      },
                    ),
                ],
              );
            },
          ),
          onDisagree: () => Navigator.of(context).pop(),
          onAgree: () {
            final int hours = int.tryParse(hoursController.text) ?? 0;
            final int minutes = int.tryParse(minutesController.text) ?? 0;

            onEdit(TimeEntry(
              hours: hours,
              minutes: minutes,
              type: selectedType,
              activity: selectedTask,  // Use the selected task
            ));
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
