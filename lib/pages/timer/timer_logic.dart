import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttfrontend/pages/tasks/tasks.dart';
import 'dart:async';

import 'package:ttfrontend/pages/timer/widgets/timer_button.dart';

class TimerLogic extends ChangeNotifier {
  WorkTimeButtonMode workTimeMode = WorkTimeButtonMode.deactivated;
  WorkTimeButtonMode drivingTimeMode = WorkTimeButtonMode.deactivated;
  Task? currentTask;

  final List<Task> dummyTasks = [
    Task(name: 'Haus bauen', id: 1),
    Task(name: 'Haus bauen', id: 1),
    Task(name: 'Haus bauen', id: 1),
    Task(name: 'Haus bauen', id: 1),
    Task(name: 'Haus bauen', id: 1),
    Task(name: 'Haus bauen', id: 1),
  ]; // Dummy tasks

  Timer? timer;
  DateTime? workTimeStartTime;
  DateTime? pauseStartTime;
  DateTime? drivingTimeStartTime;

  Duration workTimeDuration = Duration.zero;
  Duration pauseDuration = Duration.zero;
  Duration drivingTimeDuration = Duration.zero;

  bool isWorkTimeRunning = false;
  bool isPauseRunning = false;
  bool isDrivingTimeRunning = false;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  TimerLogic() {
    loadTimers();
    startTimer();
  }

  List<Task> get tasks => dummyTasks;
  Task? get selectedTask => currentTask;

  Future<void> loadTimers() async {
    final prefs = await SharedPreferences.getInstance();

    final workTimeStartTimeMillis = prefs.getInt('workTimeStartTime');
    final pauseStartTimeMillis = prefs.getInt('pauseStartTime');
    final drivingTimeStartTimeMillis = prefs.getInt('drivingTimeStartTime');

    final workTimeDurationMillis = prefs.getInt('workTimeDuration');
    final pauseDurationMillis = prefs.getInt('pauseDuration');
    final drivingTimeDurationMillis = prefs.getInt('drivingTimeDuration');

    if (workTimeStartTimeMillis != null) {
      workTimeStartTime =
          DateTime.fromMillisecondsSinceEpoch(workTimeStartTimeMillis);
      isWorkTimeRunning = true;
      workTimeMode = WorkTimeButtonMode.split;
    }

    if (pauseStartTimeMillis != null) {
      pauseStartTime =
          DateTime.fromMillisecondsSinceEpoch(pauseStartTimeMillis);
      isPauseRunning = true;
      workTimeMode = WorkTimeButtonMode.stop;
    }

    if (drivingTimeStartTimeMillis != null) {
      drivingTimeStartTime =
          DateTime.fromMillisecondsSinceEpoch(drivingTimeStartTimeMillis);
      isDrivingTimeRunning = true;
      drivingTimeMode = WorkTimeButtonMode.stop;
    }

    if (workTimeDurationMillis != null) {
      workTimeDuration = Duration(milliseconds: workTimeDurationMillis);
    }

    if (pauseDurationMillis != null) {
      pauseDuration = Duration(milliseconds: pauseDurationMillis);
    }

    if (drivingTimeDurationMillis != null) {
      drivingTimeDuration = Duration(milliseconds: drivingTimeDurationMillis);
    }

    notifyListeners();
  }

  Future<void> saveTimers() async {
    final prefs = await SharedPreferences.getInstance();

    if (workTimeStartTime != null) {
      prefs.setInt(
          'workTimeStartTime', workTimeStartTime!.millisecondsSinceEpoch);
    }

    if (pauseStartTime != null) {
      prefs.setInt('pauseStartTime', pauseStartTime!.millisecondsSinceEpoch);
    }

    if (drivingTimeStartTime != null) {
      prefs.setInt(
          'drivingTimeStartTime', drivingTimeStartTime!.millisecondsSinceEpoch);
    }

    prefs.setInt('workTimeDuration', workTimeDuration.inMilliseconds);
    prefs.setInt('pauseDuration', pauseDuration.inMilliseconds);
    prefs.setInt('drivingTimeDuration', drivingTimeDuration.inMilliseconds);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timer?.isActive ?? false) {
        _updateDurations();
      }
    });
  }

  void _updateDurations() {
    if (isWorkTimeRunning && workTimeStartTime != null) {
      if (hasListeners) {
        notifyListeners();
      }
    }

    if (isPauseRunning && pauseStartTime != null) {
      if (hasListeners) {
        notifyListeners();
      }
    }

    if (isDrivingTimeRunning && drivingTimeStartTime != null) {
      if (hasListeners) {
        notifyListeners();
      }
    }
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '$hours:${minutes.toString().padLeft(2, '0')}';
  }

  // --------------------------------------------
  void handleWorkTimePress(String action) {
    if (workTimeMode == WorkTimeButtonMode.start) {
      handleWorkTimeStart();
    } else if (workTimeMode == WorkTimeButtonMode.split) {
      if (action == 'stop') {
        handleWorkTimeStop();
      } else if (action == 'pause') {
        handleWorkTimePauseStart();
      }
    } else if (workTimeMode == WorkTimeButtonMode.stop) {
      handlePauseStop();
    }
  }

  void onTaskSelected(Task task) {
    currentTask = task;
    workTimeMode = WorkTimeButtonMode.start;
    drivingTimeMode = WorkTimeButtonMode.start;
    saveCurrentTask(task);
    notifyListeners();
  }

  Future<void> saveCurrentTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentTask', task.id);
  }

  void handleWorkTimeStart() {
    workTimeMode = WorkTimeButtonMode.split;
    handleDrivingTimeStop();

    isWorkTimeRunning = true;
    workTimeStartTime = DateTime.now();
    saveTimers();
    notifyListeners();
  }

  void handleWorkTimePauseStart() {
    workTimeMode = WorkTimeButtonMode.stop;
    isPauseRunning = true;
    pauseStartTime = DateTime.now();
    saveTimers();
    notifyListeners();
  }

  void handleWorkTimeStop() {
    workTimeMode = WorkTimeButtonMode.start;
    isWorkTimeRunning = false;

    // Add the final difference before stopping the timer to the accumulated duration
    if (workTimeStartTime != null) {
      workTimeDuration +=
          DateTime.now().difference(workTimeStartTime!) - pauseDuration;
    }

    workTimeStartTime = null;
    saveTimers();
    notifyListeners();
  }

  void handlePauseStop() {
    workTimeMode = WorkTimeButtonMode.split;
    isPauseRunning = false;

    // Add the final pause time before stopping the pause
    if (pauseStartTime != null) {
      pauseDuration += DateTime.now().difference(pauseStartTime!);
    }

    pauseStartTime = null;
    saveTimers();
    notifyListeners();
  }

  // --------------------------------------------
  void handleDrivingTimePress() {
    if (drivingTimeMode == WorkTimeButtonMode.start) {
      handleDrivingTimeStart();
    } else {
      handleDrivingTimeStop();
    }
  }

  void handleDrivingTimeStart() {
    drivingTimeMode = WorkTimeButtonMode.stop;
    if (isPauseRunning) {
      handlePauseStop();
    }
    handleWorkTimeStop();

    isDrivingTimeRunning = true;
    drivingTimeStartTime = DateTime.now();
    saveTimers();
    notifyListeners();
  }

  void handleDrivingTimeStop() {
    drivingTimeMode = WorkTimeButtonMode.start;
    isDrivingTimeRunning = false;

    // Add the final driving time before stopping
    if (drivingTimeStartTime != null) {
      drivingTimeDuration += DateTime.now().difference(drivingTimeStartTime!);
    }

    drivingTimeStartTime = null;
    saveTimers();
    notifyListeners();
  }
}
