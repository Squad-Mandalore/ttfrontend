import 'package:flutter/material.dart';
import 'package:ttfrontend/pages/timer/widgets/aufgaben_button.dart';
import 'package:ttfrontend/pages/timer/widgets/timer_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  ArbeitszeitButtonMode _arbeitszeitMode = ArbeitszeitButtonMode.deactivated;
  ArbeitszeitButtonMode _fahrtzeitMode = ArbeitszeitButtonMode.deactivated;
  String? _currentTask;

  @override
  void initState() {
    super.initState();
    _loadCurrentTask(); // Load the task when the app starts
  }

  // Load the task from shared preferences
  Future<void> _loadCurrentTask() async {
    final prefs = await SharedPreferences.getInstance();
    final task = prefs.getString('currentTask');

    // Set state once the task is loaded
    if (task != null) {
      setState(() {
        _currentTask = task;
        _arbeitszeitMode = ArbeitszeitButtonMode.start;
        _fahrtzeitMode = ArbeitszeitButtonMode.start;
      });
    }
  }

  // Save the task to shared preferences
  Future<void> _saveCurrentTask(String task) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentTask', task);
  }

  // Callback for when a task is selected
  void _onTaskSelected(String task) {
    setState(() {
      _arbeitszeitMode = _arbeitszeitMode == ArbeitszeitButtonMode.deactivated
          ? ArbeitszeitButtonMode.start
          : _arbeitszeitMode;
      _fahrtzeitMode = _fahrtzeitMode == ArbeitszeitButtonMode.deactivated
          ? ArbeitszeitButtonMode.start
          : _fahrtzeitMode;
    });
    _saveCurrentTask(task);
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding =
        MediaQuery.of(context).size.width * 0.1; // 10% padding

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding), // Global 10% padding
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Center the content
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Arbeitszeit Section
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
            AufgabenButton(
              onTaskSelected: _onTaskSelected,
              initialTask: _currentTask,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Arbeitszeit",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            ArbeitszeitButton(
              buttonText: _arbeitszeitMode == ArbeitszeitButtonMode.start
                  ? "Arbeitszeit Starten"
                  : "Pause beenden",
              secondaryText: "heute 1 min",
              mode: _arbeitszeitMode,
              onPressed: () => _handleArbeitszeitPress('stop'),
              onPausePressed: () => _handleArbeitszeitPress('pause'),
              onStopPressed: () => _handleArbeitszeitPress('stop'),
            ),

            // Fahrtzeit Section
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
            ArbeitszeitButton(
              buttonText: _fahrtzeitMode == ArbeitszeitButtonMode.start
                  ? "Fahrtzeit Starten"
                  : "Fahrt beenden",
              secondaryText: "heute 1 min",
              mode: _fahrtzeitMode,
              onPressed: _handleFahrtzeitPress,
              onPausePressed: null,
              onStopPressed: _handleFahrtzeitPress,
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  // Transition logic for the Arbeitszeit button
  void _handleArbeitszeitPress(String action) {
    setState(() {
      if (_arbeitszeitMode == ArbeitszeitButtonMode.start) {
        _arbeitszeitMode = ArbeitszeitButtonMode.split;
        _fahrtzeitMode = ArbeitszeitButtonMode.start;
      } else if (_arbeitszeitMode == ArbeitszeitButtonMode.split) {
        if (action == 'stop') {
          _arbeitszeitMode = ArbeitszeitButtonMode.start;
        } else if (action == 'pause') {
          _arbeitszeitMode = ArbeitszeitButtonMode.stop;
        }
      } else if (_arbeitszeitMode == ArbeitszeitButtonMode.stop) {
        _arbeitszeitMode = ArbeitszeitButtonMode.split;
      }
    });
  }

  // Transition logic for the Fahrtzeit button
  void _handleFahrtzeitPress() {
    setState(() {
      if (_fahrtzeitMode == ArbeitszeitButtonMode.start) {
        _fahrtzeitMode = ArbeitszeitButtonMode.stop;
        _arbeitszeitMode = ArbeitszeitButtonMode.start;
      } else {
        _fahrtzeitMode = ArbeitszeitButtonMode.start;
      }
    });
  }
}
