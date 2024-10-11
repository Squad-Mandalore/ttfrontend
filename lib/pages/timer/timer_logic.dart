import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:ttfrontend/pages/timer/widgets/timer_button.dart';
import 'package:ttfrontend/service/models/task.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';

import 'package:ttfrontend/service/api_service.dart';
import 'package:ttfrontend/service/models/graphql_query.dart';

class TimerLogic extends ChangeNotifier {
  WorkTimeButtonMode workTimeMode = WorkTimeButtonMode.deactivated;
  WorkTimeButtonMode drivingTimeMode = WorkTimeButtonMode.deactivated;
  Task? currentTask;
  Task? nextTask;

  Timer? timer;
  DateTime? workTimeStartTime;
  DateTime? pauseStartTime;
  DateTime? drivingTimeStartTime;

  Duration workTimeDuration = Duration.zero;
  Duration pauseDuration = Duration.zero;
  Duration drivingTimeDuration = Duration.zero;

  List<Duration> finishedWorkTimes = [];
  List<Duration> finishedPauseTimes = [];
  List<Duration> finishedDrivingTimes = [];

  bool isWorkTimeRunning = false;
  bool isPauseRunning = false;
  bool isDrivingTimeRunning = false;

  final ApiService apiService = ApiService();
  int? currentWorktimeId;

  @override
  void dispose() {
    saveTimesToPrefs();
    timer?.cancel();
    super.dispose();
  }

  TimerLogic() {
    loadTask();
    loadTimesFromPrefs();
    _updateDurations();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _updateDurations();
    });
  }

  Future<void> loadTask() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTaskJson = prefs.getString('currentTask');

    if (currentTaskJson != null) {
      currentTask =
          Task.fromJson(json.decode(currentTaskJson) as Map<String, dynamic>);
    }
    if (currentTask != null) {
      activateButtons();
    }
  }

  Future<void> saveTimesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // Save finished times
    prefs.setString('finishedWorkTimes',
        jsonEncode(finishedWorkTimes.map((d) => d.inMilliseconds).toList()));
    prefs.setString('finishedPauseTimes',
        jsonEncode(finishedPauseTimes.map((d) => d.inMilliseconds).toList()));
    prefs.setString('finishedDrivingTimes',
        jsonEncode(finishedDrivingTimes.map((d) => d.inMilliseconds).toList()));

    // Save start times
    prefs.setString(
        'workTimeStartTime', workTimeStartTime?.toIso8601String() ?? '');
    prefs.setString('pauseStartTime', pauseStartTime?.toIso8601String() ?? '');
    prefs.setString(
        'drivingTimeStartTime', drivingTimeStartTime?.toIso8601String() ?? '');

    // Save today's date
    prefs.setString(
        'savedDate', DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  Future<void> loadTimesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String? savedDate = prefs.getString('savedDate');

    if (savedDate != null && savedDate == todayDate) {
      // Load finished times
      String? finishedWorkTimesJson = prefs.getString('finishedWorkTimes');
      if (finishedWorkTimesJson != null && finishedWorkTimesJson.isNotEmpty) {
        List<dynamic> millisList = jsonDecode(finishedWorkTimesJson);
        finishedWorkTimes =
            millisList.map((ms) => Duration(milliseconds: ms)).toList();
      }

      String? finishedPauseTimesJson = prefs.getString('finishedPauseTimes');
      if (finishedPauseTimesJson != null && finishedPauseTimesJson.isNotEmpty) {
        List<dynamic> millisList = jsonDecode(finishedPauseTimesJson);
        finishedPauseTimes =
            millisList.map((ms) => Duration(milliseconds: ms)).toList();
      }

      String? finishedDrivingTimesJson =
          prefs.getString('finishedDrivingTimes');
      if (finishedDrivingTimesJson != null &&
          finishedDrivingTimesJson.isNotEmpty) {
        List<dynamic> millisList = jsonDecode(finishedDrivingTimesJson);
        finishedDrivingTimes =
            millisList.map((ms) => Duration(milliseconds: ms)).toList();
      }

      // Load start times
      String? workTimeStartTimeString = prefs.getString('workTimeStartTime');
      if (workTimeStartTimeString != null &&
          workTimeStartTimeString.isNotEmpty) {
        workTimeStartTime = DateTime.parse(workTimeStartTimeString);
      }

      String? pauseStartTimeString = prefs.getString('pauseStartTime');
      if (pauseStartTimeString != null && pauseStartTimeString.isNotEmpty) {
        pauseStartTime = DateTime.parse(pauseStartTimeString);
      }

      String? drivingTimeStartTimeString =
          prefs.getString('drivingTimeStartTime');
      if (drivingTimeStartTimeString != null &&
          drivingTimeStartTimeString.isNotEmpty) {
        drivingTimeStartTime = DateTime.parse(drivingTimeStartTimeString);
      }

      // Set running states
      isWorkTimeRunning = workTimeStartTime != null;
      isPauseRunning = pauseStartTime != null;
      isDrivingTimeRunning = drivingTimeStartTime != null;

      // Set button modes
      if (currentTask != null) {
        activateButtons();
      }

      if (isWorkTimeRunning) {
        workTimeMode = WorkTimeButtonMode.split;
      } else if (isPauseRunning) {
        workTimeMode = WorkTimeButtonMode.stop;
      } else {
        workTimeMode = WorkTimeButtonMode.start;
      }

      if (isDrivingTimeRunning) {
        drivingTimeMode = WorkTimeButtonMode.stop;
      } else {
        drivingTimeMode = WorkTimeButtonMode.start;
      }

      notifyListeners();
    } else {
      // Data is not from today, clear it
      finishedWorkTimes = [];
      finishedPauseTimes = [];
      finishedDrivingTimes = [];
      workTimeStartTime = null;
      pauseStartTime = null;
      drivingTimeStartTime = null;
      isWorkTimeRunning = false;
      isPauseRunning = false;
      isDrivingTimeRunning = false;
      workTimeMode = WorkTimeButtonMode.deactivated;
      drivingTimeMode = WorkTimeButtonMode.deactivated;
      saveTimesToPrefs();
      notifyListeners();
    }
  }

  void _updateDurations() {
    final now = DateTime.now();

    workTimeDuration = Duration.zero;
    if (isWorkTimeRunning && workTimeStartTime != null) {
      workTimeDuration += now.difference(workTimeStartTime!);
    }
    if (finishedWorkTimes.isNotEmpty) {
      workTimeDuration +=
          finishedWorkTimes.fold(Duration.zero, (a, b) => a + b);
    }

    pauseDuration = Duration.zero;
    if (isPauseRunning && pauseStartTime != null) {
      pauseDuration += now.difference(pauseStartTime!);
    }
    if (finishedPauseTimes.isNotEmpty) {
      pauseDuration += finishedPauseTimes.fold(Duration.zero, (a, b) => a + b);
    }

    drivingTimeDuration = Duration.zero;
    if (isDrivingTimeRunning && drivingTimeStartTime != null) {
      drivingTimeDuration += now.difference(drivingTimeStartTime!);
    }
    if (finishedDrivingTimes.isNotEmpty) {
      drivingTimeDuration +=
          finishedDrivingTimes.fold(Duration.zero, (a, b) => a + b);
    }
    notifyListeners();
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '$hours:${minutes.toString().padLeft(2, '0')}';
  }

  // --------------------------------------------
  void handleWorkTimePress(BuildContext context, String action) {
    if (workTimeMode == WorkTimeButtonMode.start) {
      handleWorkTimeStart();
    } else if (workTimeMode == WorkTimeButtonMode.split) {
      if (action == 'stop') {
        handleWorkTimeStop();
      } else if (action == 'pause') {
        handleWorkTimeStop();
        handlePauseStart();
      }
    } else if (workTimeMode == WorkTimeButtonMode.stop) {
      handlePauseStop(context);
    }
    saveTimesToPrefs();
  }

  void onTaskSelected(Task task) {
    if (isDrivingTimeRunning) {
      handleDrivingTimeStop();
    }
    if (isWorkTimeRunning) {
      handleWorkTimeStop();
    }
    if (isPauseRunning) {
      workTimeMode = WorkTimeButtonMode.stop;
      nextTask = task;
      return;
    }
    currentTask = task;
    activateButtons();
    saveCurrentTask(task);
    notifyListeners();
  }

  void activateButtons() {
    if (workTimeMode == WorkTimeButtonMode.deactivated) {
      workTimeMode = WorkTimeButtonMode.start;
    }
    if (drivingTimeMode == WorkTimeButtonMode.deactivated) {
      drivingTimeMode = WorkTimeButtonMode.start;
    }
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

    final result = await apiService
        .graphQLRequest(GraphQLQuery(query: workTimeStartMutation, variables: {
      'taskId': currentTask?.id,
      'worktype': 'WORK',
    }));
    currentWorktimeId = result.data?['startTimer']['worktimeId'];
    try {
      workTimeStartTime =
          DateTime.parse(result.data?['startTimer']['startTime']);
    } catch (e) {
      workTimeStartTime = DateTime.now();
    }
    _updateDurations();
  }

  void handlePauseStart() async {
    workTimeMode = WorkTimeButtonMode.stop;
    isPauseRunning = true;
    notifyListeners();

    var pauseStartMutation = r"""
      mutation ($taskId: Int!, $worktype: String!) {
        startTimer (taskId: $taskId, worktype: $worktype) {
          startTime
          worktimeId
      }
    }
    """;

    final result = await apiService
        .graphQLRequest(GraphQLQuery(query: pauseStartMutation, variables: {
      'taskId': currentTask?.id,
      'worktype': 'BREAK',
    }));

    currentWorktimeId = result.data?['startTimer']['worktimeId'];
    try {
      pauseStartTime = DateTime.parse(result.data?['startTimer']['startTime']);
    } catch (e) {
      pauseStartTime = DateTime.now();
    }
    _updateDurations();
  }

  void handleWorkTimeStop() async {
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
      final result = await apiService
          .graphQLRequest(GraphQLQuery(query: workTimeStopMutation, variables: {
        'worktimeId': currentWorktimeId,
      }));
      final endTime = result.data?['stopTimer']['endTime'];
      final startTime = result.data?['stopTimer']['startTime'];
      try {
        finishedWorkTimes.add(DateTime.parse(endTime).difference(DateTime.parse(startTime)));
      } catch (e) {
        finishedWorkTimes.add(workTimeDuration);
      }
      workTimeDuration = Duration.zero;
      workTimeStartTime = null;
      _updateDurations();
    }
  }

  void handlePauseStop(BuildContext context) async {
    workTimeMode = WorkTimeButtonMode.split;

    var pauseStopMutation = r"""
      mutation ($worktimeId: Int!) {
        stopTimer (worktimeId: $worktimeId) {
          worktimeId
          startTime
          endTime
        }
      }
    """;

    final result = await apiService
        .graphQLRequest(GraphQLQuery(query: pauseStopMutation, variables: {
      'worktimeId': currentWorktimeId,
    }));
    isPauseRunning = false;
    if (nextTask != null) {
      saveCurrentTask(nextTask!);
      nextTask = null;
    }

    if (pauseDuration < const Duration(minutes: 30) && context.mounted) {
      // format to show only minutes
      final formattedPauseDuration = pauseDuration.inMinutes;
      String pauseWarning =
          "Du hast heute erst $formattedPauseDuration Minuten Pause gemacht. Stelle sicher, dass du die 30 Minuten noch erreichst.";
      GenericPopup.showWarningPopup(context, pauseWarning, "Pausen Warnung");
    }
    notifyListeners();
    final endTime = result.data?['stopTimer']['endTime'];
    final startTime = result.data?['stopTimer']['startTime'];

    try {
      finishedPauseTimes.add(DateTime.parse(endTime).difference(DateTime.parse(startTime)));
    } catch (e) {
      finishedPauseTimes.add(pauseDuration);
    }
    pauseDuration = Duration.zero;
    pauseStartTime = null;
    _updateDurations();

    handleWorkTimeStart();
  }

  // --------------------------------------------
  void handleDrivingTimePress(BuildContext context) {
    _updateDurations();
    if (drivingTimeMode == WorkTimeButtonMode.start) {
      handleDrivingTimeStart(context);
    } else {
      handleDrivingTimeStop();
    }
  }

  void handleDrivingTimeStart(BuildContext context) async {
    drivingTimeMode = WorkTimeButtonMode.stop;
    if (isPauseRunning) {
      handlePauseStop(context);
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

    final result = await apiService.graphQLRequest(
        GraphQLQuery(query: drivingTimeStartMutation, variables: {
      'taskId': currentTask?.id,
      'worktype': 'RIDE',
    }));

    currentWorktimeId = result.data?['startTimer']['worktimeId'];
    try {
      drivingTimeStartTime =
          DateTime.parse(result.data?['startTimer']['startTime']);
    } catch (e) {
      drivingTimeStartTime = DateTime.now();
    }
  }

  void handleDrivingTimeStop() async {
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
      final result = await apiService.graphQLRequest(
          GraphQLQuery(query: drivingTimeStopMutation, variables: {
        'worktimeId': currentWorktimeId,
      }));
      final endTime = result.data?['stopTimer']['endTime'];
      final startTime = result.data?['stopTimer']['startTime'];
      try {
        finishedDrivingTimes.add(DateTime.parse(endTime).difference(DateTime.parse(startTime)));
      } catch (e) {
        finishedDrivingTimes.add(drivingTimeDuration);
      }
      drivingTimeDuration = Duration.zero;
      drivingTimeStartTime = null;
      _updateDurations();
    }
  }
}
