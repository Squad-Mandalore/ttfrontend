import 'package:flutter/material.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';
import 'package:ttfrontend/pages/overview/utils/overview_logic.dart';
import 'package:ttfrontend/pages/timer/widgets/tasks_button.dart';
import 'package:ttfrontend/service/models/task.dart';

class OverviewPopupLogic {
  static void showEditPopup(
    BuildContext context,
    TimeEntry entry,
    Function(TimeEntry) onEdit,
    List<Task> availableTasks, // Pass in the available tasks
  ) {
    final List<String> timeTypes = ['Fahrtzeit', 'Arbeitszeit', 'Pause'];
    String selectedType = entry.type;
    Task selectedTask = entry.activity;

    // Initialize the start and end time controllers
    TimeOfDay selectedStartTime =
        TimeOfDay(hour: entry.startTime.hour, minute: entry.startTime.minute);
    TimeOfDay selectedEndTime =
        TimeOfDay(hour: entry.endTime.hour, minute: entry.endTime.minute);

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
                        child: TextFormField(
                          readOnly: true,
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: selectedStartTime,
                              helpText: "Startzeit",
                              hourLabelText: 'Stunde',
                              minuteLabelText: 'Minute',
                              confirmText: 'Bestätigen',
                              cancelText: 'Abbrechen',
                            );
                            if (picked != null && picked != selectedStartTime) {
                              setState(() {
                                selectedStartTime = picked;
                              });
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Startzeit',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),
                          ),
                          controller: TextEditingController(
                              text: selectedStartTime.format(context)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: selectedEndTime,
                              helpText: "Endzeit",
                              hourLabelText: 'Stunde',
                              minuteLabelText: 'Minute',
                              confirmText: 'Bestätigen',
                              cancelText: 'Abbrechen',
                            );
                            if (picked != null && picked != selectedEndTime) {
                              setState(() {
                                selectedEndTime = picked;
                              });
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Endzeit',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),
                          ),
                          controller: TextEditingController(
                              text: selectedEndTime.format(context)),
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
                          selectedTask =
                              Task(id: -1, name: 'Neue Aufgabe zuweisen');
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (selectedType != 'Pause')
                    TasksButton(
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
            onEdit(TimeEntry(
              startTime: DateTime(
                entry.startTime.year,
                entry.startTime.month,
                entry.startTime.day,
                selectedStartTime.hour,
                selectedStartTime.minute,
              ),
              endTime: DateTime(
                entry.endTime.year,
                entry.endTime.month,
                entry.endTime.day,
                selectedEndTime.hour,
                selectedEndTime.minute,
              ),
              type: selectedType,
              activity: selectedTask,
              worktimeId: entry.worktimeId,
            ));
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
