import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:ttfrontend/pages/timer/widgets/timer_button.dart';
import 'package:ttfrontend/service/models/task.dart';

import 'package:ttfrontend/service/api_service.dart';
import 'package:ttfrontend/service/models/graphql_query.dart';
import 'package:ttfrontend/service/task_service.dart';

class TimerLogic extends ChangeNotifier {
  WorkTimeButtonMode workTimeMode = WorkTimeButtonMode.deactivated;
  WorkTimeButtonMode drivingTimeMode = WorkTimeButtonMode.deactivated;
  Task? currentTask;

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

  final ApiService apiService = ApiService();
  int? currentWorktimeId;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  TimerLogic() {
    loadTask();
    startTimer();
  }

  Future<void> loadTask() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTaskJson = prefs.getString('currentTask');

    if (currentTaskJson != null) {
      currentTask =
          Task.fromJson(json.decode(currentTaskJson) as Map<String, dynamic>);
    }
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
      if (isPauseRunning) {
        handlePauseStop();
      }
      else {
        handleWorkTimeStop();
      }
    }
  }

  void onTaskSelected(Task task) {
    if (isDrivingTimeRunning) {
      handleDrivingTimeStop();
    }
    if (isWorkTimeRunning) {
      handleWorkTimeStop();
    }
    currentTask = task;
    if (workTimeMode == WorkTimeButtonMode.deactivated) {
      workTimeMode = WorkTimeButtonMode.start;
    }
    if (drivingTimeMode == WorkTimeButtonMode.deactivated) {
      drivingTimeMode = WorkTimeButtonMode.start;
    }
    saveCurrentTask(task);
    notifyListeners();

  }

  Future<void> saveCurrentTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentTask', jsonEncode(task));
  }

  void handleWorkTimeStart() async {
    workTimeMode = WorkTimeButtonMode.split;
    if (isDrivingTimeRunning) {
      handleDrivingTimeStop();
    }

    isWorkTimeRunning = true;
    notifyListeners();

    var workTimeStartMutation = r"""
    mutation ($taskId: Int!, $worktype: String!) {
      startTimer (taskId: $taskId, worktype: $worktype) {
        startTime
        worktimeId
      }
    }
    """;

    final result = await apiService.graphQLRequest(GraphQLQuery(query: workTimeStartMutation, variables: {
      'taskId': currentTask?.id,
      'worktype': 'WORK',
    }));
    currentWorktimeId = result.data?['startTimer']['worktimeId'];
  }

  void handleWorkTimePauseStart() async {
    workTimeMode = WorkTimeButtonMode.stop;
    isPauseRunning = true;
    notifyListeners();

    var workTimePauseStartMutation = r"""
      mutation ($taskId: Int!, $worktype: String!) {
        startTimer (taskId: $taskId, worktype: $worktype) {
          startTime
          worktimeId
      }
    }
    """;

    final result = await apiService.graphQLRequest(GraphQLQuery(query: workTimePauseStartMutation, variables: {
      'taskId': currentTask?.id,
      'worktype': 'BREAK',
    }));

    var workTimePauseStopMutation = r"""
      mutation ($worktimeId: Int!) {
        stopTimer (worktimeId: $worktimeId) {
          startTime
          endTime
        }
      }
    """;

    apiService.graphQLRequest(GraphQLQuery(query: workTimePauseStopMutation, variables: {
      'worktimeId': currentWorktimeId,
    }));

    currentWorktimeId = result.data?['startTimer']['worktimeId'];
  }

  void handleWorkTimeStop() {
    workTimeMode = WorkTimeButtonMode.start;
    isWorkTimeRunning = false;

    notifyListeners();

    var workTimeStopMutation = r"""
      mutation ($worktimeId: Int!) {
        stopTimer (worktimeId: $worktimeId) {
          worktimeId
          startTime
          endTime
        }
      }
    """;
    if (currentWorktimeId != null) {
      apiService.graphQLRequest(GraphQLQuery(query: workTimeStopMutation, variables: {
        'worktimeId': currentWorktimeId,
      }));
    }
  }

  void handlePauseStop() {
    workTimeMode = WorkTimeButtonMode.split;
    isPauseRunning = false;

    var pauseStopMutation = r"""
      mutation ($worktimeId: Int!) {
        stopTimer (worktimeId: $worktimeId) {
          worktimeId
          startTime
          endTime
        }
      }
    """;

    apiService.graphQLRequest(GraphQLQuery(query: pauseStopMutation, variables: {
      'worktimeId': currentWorktimeId,
    }));

    handleWorkTimeStart();
    isPauseRunning = false;
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

  void handleDrivingTimeStart() async {
    drivingTimeMode = WorkTimeButtonMode.stop;
    if (isPauseRunning) {
      handlePauseStop();
    }
    handleWorkTimeStop();

    isDrivingTimeRunning = true;
    notifyListeners();

    var drivingTimeStartMutation = r"""
      mutation ($taskId: Int!, $worktype: String!) {
        startTimer (taskId: $taskId, worktype: $worktype) {
          startTime
          worktimeId
        }
      }
    """;

    final result = await apiService.graphQLRequest(GraphQLQuery(query: drivingTimeStartMutation, variables: {
      'taskId': currentTask?.id,
      'worktype': 'RIDE',
    }));

    currentWorktimeId = result.data?['startTimer']['worktimeId'];
  }

  void handleDrivingTimeStop() {
    drivingTimeMode = WorkTimeButtonMode.start;
    isDrivingTimeRunning = false;

    notifyListeners();

    var drivingTimeStopMutation = r"""
      mutation ($worktimeId: Int!) {
        stopTimer (worktimeId: $worktimeId) {
          worktimeId
          startTime
          endTime
        }
      }
    """;
    if (currentWorktimeId != null) {
      apiService.graphQLRequest(GraphQLQuery(query: drivingTimeStopMutation, variables: {
      'worktimeId': currentWorktimeId,
      }));
    }

  }
}
