import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ttfrontend/pages/timer/widgets/timer_button.dart';
import 'package:ttfrontend/service/models/graphql_response.dart';
import 'package:ttfrontend/service/models/task.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';
import 'package:ttfrontend/service/api_service.dart';
import 'package:ttfrontend/service/models/graphql_query.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

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
    timer?.cancel();
    super.dispose();
  }

  TimerLogic() {
    loadTask();
    fetchTimersForToday();
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

  Future<void> fetchTimersForToday() async {
    const String query = r'''
      query TimersInBoundary($lowerBound: DateTime!, $upperBound: DateTime!) {
        timersInBoundary(lowerBound: $lowerBound, upperBound: $upperBound) {
          startTime
          endTime
          workType
          worktimeId
          task {
            taskDescription
            taskId
          }
        }
      }
    ''';

    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString();
    String day = now.day.toString();

    String formatDateTimeString(
        String year, String month, String day, String time) {
      return '$year-${month.padLeft(2, '0')}-${day.padLeft(2, '0')}T$time' 'Z';
    }

    String lowerBound = formatDateTimeString(year, month, day, '00:00:00');
    String upperBound = formatDateTimeString(year, month, day, '23:59:59');

    try {
      GraphQLQuery graphQLQuery = GraphQLQuery(
        query: query,
        variables: {
          'lowerBound': lowerBound,
          'upperBound': upperBound,
        },
      );

      GraphQLResponse response = await apiService.graphQLRequest(graphQLQuery);

      final timers = response.data?['timersInBoundary'];
      if (timers != null) {
        for (var timer in timers) {
          if (timer is! Map ||
              timer['task'] == null ||
              timer['task'] is! Map ||
              timer['task'].isEmpty ||
              timer['startTime'] == null) {
            continue;
          }
          try {
            final DateTime startTime = DateTime.parse(timer['startTime']);
            final String workType = timer['workType'];
            final DateTime? endTime = timer['endTime'] != null
                ? DateTime.parse(timer['endTime'])
                : null;

            // Set currentTask if not already set
            if (currentTask == null) {
              currentTask = Task(
                id: timer['task']['taskId'],
                name: timer['task']['taskDescription'],
              );
              activateButtons();
              saveCurrentTask(currentTask!);
            }

            // Process the timer
            if (endTime != null) {
              // Finished timers
              Duration duration = endTime.difference(startTime);
              if (workType == 'WORK') {
                finishedWorkTimes.add(duration);
              } else if (workType == 'BREAK') {
                finishedPauseTimes.add(duration);
              } else if (workType == 'RIDE') {
                finishedDrivingTimes.add(duration);
              }
            } else {
              // Ongoing timers
              if (workType == 'WORK') {
                isWorkTimeRunning = true;
                workTimeStartTime = startTime;
                currentWorktimeId = timer['worktimeId'];
                workTimeMode = WorkTimeButtonMode.split;
              } else if (workType == 'BREAK') {
                isPauseRunning = true;
                pauseStartTime = startTime;
                currentWorktimeId = timer['worktimeId'];
                workTimeMode = WorkTimeButtonMode.stop;
              } else if (workType == 'RIDE') {
                isDrivingTimeRunning = true;
                drivingTimeStartTime = startTime;
                currentWorktimeId = timer['worktimeId'];
                drivingTimeMode = WorkTimeButtonMode.stop;
              }
            }
          } catch (e) {
            // Hehehehehe
            continue;
          }
        }
      }

      // Set default button modes if not already set
      if (workTimeMode == WorkTimeButtonMode.deactivated) {
        workTimeMode = WorkTimeButtonMode.start;
      }
      if (drivingTimeMode == WorkTimeButtonMode.deactivated) {
        drivingTimeMode = WorkTimeButtonMode.start;
      }

      _updateDurations();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch timers for today: $e');
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
        finishedWorkTimes
            .add(DateTime.parse(endTime).difference(DateTime.parse(startTime)));
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
      finishedPauseTimes
          .add(DateTime.parse(endTime).difference(DateTime.parse(startTime)));
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
        finishedDrivingTimes
            .add(DateTime.parse(endTime).difference(DateTime.parse(startTime)));
      } catch (e) {
        finishedDrivingTimes.add(drivingTimeDuration);
      }
      drivingTimeDuration = Duration.zero;
      drivingTimeStartTime = null;
      _updateDurations();
    }
  }
}
