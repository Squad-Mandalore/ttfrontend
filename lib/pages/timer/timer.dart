// timer.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'timer_logic.dart'; // Importing the logic file
import 'package:ttfrontend/pages/timer/widgets/tasks_button.dart';
import 'package:ttfrontend/pages/timer/widgets/timer_button.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = MediaQuery.of(context).size.width * 0.1;

    return Consumer<TimerLogic>(
      builder: (context, logic, child) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Momentane Aufgabe Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Momentane Aufgabe",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                TasksButton(
                  onTaskSelected: logic.onTaskSelected,
                  initialTask: logic.currentTask,
                ),

                // WorkTime Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      logic.isPauseRunning
                          ? "Arbeitszeit: ${logic.formatDuration(logic.workTimeDuration)}"
                          : "Arbeitszeit",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                WorkTimeButton(
                  // For WorkTimeButton
                  buttonText: logic.isPauseRunning
                      ? "Pause beenden"
                      : logic.isWorkTimeRunning
                          ? "Arbeitszeit stoppen"
                          : "Arbeitszeit starten",

                  secondaryText: logic.workTimeMode ==
                          WorkTimeButtonMode.deactivated
                      ? "Wähle eine Aufgabe"
                      : logic.isPauseRunning
                          ? "Pause: ${logic.formatDuration(logic.pauseDuration)}"
                          : logic.isWorkTimeRunning ||
                                  logic.workTimeDuration >
                                      const Duration(minutes: 1)
                              ? "Arbeitszeit: ${logic.formatDuration(logic.workTimeDuration)}"
                              : "Starte deine Arbeitszeit",
                  mode: logic.workTimeMode,
                  onPressed: () => logic.handleWorkTimePress(context, 'stop'),
                  onPausePressed: () => logic.handleWorkTimePress(context, 'pause'),
                  onStopPressed: () =>
                      logic.handleWorkTimePress(context, 'stop'),
                ),

                // DrivingTime Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Fahrtzeit",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                WorkTimeButton(
                  buttonText: logic.isDrivingTimeRunning
                      ? "Fahrt stoppen"
                      : "Fahrt starten",
                  secondaryText: logic.drivingTimeMode ==
                          WorkTimeButtonMode.deactivated
                      ? "Wähle eine Aufgabe"
                      : logic.drivingTimeDuration < const Duration(minutes: 1)
                          ? "Starte deine Fahrtzeit"
                          : "Fahrt ${logic.formatDuration(logic.drivingTimeDuration)}",
                  mode: logic.drivingTimeMode,
                  onPressed: () => logic.handleDrivingTimePress(context),
                  onStopPressed: () => logic.handleDrivingTimePress(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
