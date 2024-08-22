import 'package:flutter/material.dart';
import 'package:ttfrontend/pages/timer/widgets/aufgaben_button.dart';
import 'package:ttfrontend/pages/timer/widgets/timer_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  ArbeitszeitButtonMode _arbeitszeitMode = ArbeitszeitButtonMode.deactivated;
  ArbeitszeitButtonMode _fahrtzeitMode = ArbeitszeitButtonMode.deactivated;
  String? _currentTask;

  Timer? _timer;
  DateTime? _arbeitszeitStartTime;
  DateTime? _pauseStartTime;
  DateTime? _fahrtzeitStartTime;

  Duration _arbeitszeitDuration = Duration.zero;
  Duration _pauseDuration = Duration.zero;
  Duration _fahrtzeitDuration = Duration.zero;

  bool _isArbeitszeitRunning = false;
  bool _isPauseRunning = false;
  bool _isFahrtzeitRunning = false;

  final List<String> _dummyTasks = [
    'Haus bauen',
    'Auto reparieren',
    'Auto klauen',
    'Eine ganz lange Autobahn entlang fahren',
  ]; // Dummy tasks

  @override
  void initState() {
    super.initState();
    _loadCurrentTask();
    _loadTimers();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadTimers() async {
    final prefs = await SharedPreferences.getInstance();

    final arbeitszeitStartTimeMillis = prefs.getInt('arbeitszeitStartTime');
    final pauseStartTimeMillis = prefs.getInt('pauseStartTime');
    final fahrtzeitStartTimeMillis = prefs.getInt('fahrtzeitStartTime');

    final arbeitszeitDurationMillis = prefs.getInt('arbeitszeitDuration');
    final pauseDurationMillis = prefs.getInt('pauseDuration');
    final fahrtzeitDurationMillis = prefs.getInt('fahrtzeitDuration');

    setState(() {
      if (arbeitszeitStartTimeMillis != null) {
        _arbeitszeitStartTime =
            DateTime.fromMillisecondsSinceEpoch(arbeitszeitStartTimeMillis);
        _isArbeitszeitRunning = true;
        _arbeitszeitMode = ArbeitszeitButtonMode.split;
      }

      if (pauseStartTimeMillis != null) {
        _pauseStartTime =
            DateTime.fromMillisecondsSinceEpoch(pauseStartTimeMillis);
        _isPauseRunning = true;
        _arbeitszeitMode = ArbeitszeitButtonMode.stop;
      }

      if (fahrtzeitStartTimeMillis != null) {
        _fahrtzeitStartTime =
            DateTime.fromMillisecondsSinceEpoch(fahrtzeitStartTimeMillis);
        _isFahrtzeitRunning = true;
        _fahrtzeitMode = ArbeitszeitButtonMode.stop;
      }

      if (arbeitszeitDurationMillis != null) {
        _arbeitszeitDuration =
            Duration(milliseconds: arbeitszeitDurationMillis);
      }

      if (pauseDurationMillis != null) {
        _pauseDuration = Duration(milliseconds: pauseDurationMillis);
      }

      if (fahrtzeitDurationMillis != null) {
        _fahrtzeitDuration = Duration(milliseconds: fahrtzeitDurationMillis);
      }
    });
  }

  Future<void> _saveTimers() async {
    final prefs = await SharedPreferences.getInstance();

    if (_arbeitszeitStartTime != null) {
      prefs.setInt('arbeitszeitStartTime',
          _arbeitszeitStartTime!.millisecondsSinceEpoch);
    }

    if (_pauseStartTime != null) {
      prefs.setInt('pauseStartTime', _pauseStartTime!.millisecondsSinceEpoch);
    }

    if (_fahrtzeitStartTime != null) {
      prefs.setInt(
          'fahrtzeitStartTime', _fahrtzeitStartTime!.millisecondsSinceEpoch);
    }

    prefs.setInt('arbeitszeitDuration', _arbeitszeitDuration.inMilliseconds);
    prefs.setInt('pauseDuration', _pauseDuration.inMilliseconds);
    prefs.setInt('fahrtzeitDuration', _fahrtzeitDuration.inMilliseconds);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _updateDurations();
        });
      }
    });
  }

  void _updateDurations() {
    final now = DateTime.now();

    if (_isArbeitszeitRunning && _arbeitszeitStartTime != null) {
      _arbeitszeitDuration =
          now.difference(_arbeitszeitStartTime!) - _pauseDuration;
    }

    if (_isPauseRunning && _pauseStartTime != null) {
      _pauseDuration += now.difference(_pauseStartTime!);
      _pauseStartTime = now;
    }

    if (_isFahrtzeitRunning && _fahrtzeitStartTime != null) {
      _fahrtzeitDuration = now.difference(_fahrtzeitStartTime!);
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '$hours:${minutes.toString().padLeft(2, '0')}';
  }

  // Load the task from shared preferences
  Future<void> _loadCurrentTask() async {
    final prefs = await SharedPreferences.getInstance();
    final task = prefs.getString('currentTask');

    if (task != null) {
      setState(() {
        _currentTask = task;
        _arbeitszeitMode = ArbeitszeitButtonMode.start;
        _fahrtzeitMode = ArbeitszeitButtonMode.start;
      });
    }
  }

  Future<void> _saveCurrentTask(String task) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentTask', task);
  }

  void _onTaskSelected(String task) {
    setState(() {
      _currentTask = task;
      _arbeitszeitMode = ArbeitszeitButtonMode.start;
      _fahrtzeitMode = ArbeitszeitButtonMode.start;
    });
    _saveCurrentTask(task);
  }

  // --------------------------------------------

  void _handleArbeitszeitPress(String action) {
    setState(() {
      if (_arbeitszeitMode == ArbeitszeitButtonMode.start) {
        _handleArbeitszeitStart();
      } else if (_arbeitszeitMode == ArbeitszeitButtonMode.split) {
        if (action == 'stop') {
          _handleArbeitszeitStop();
        } else if (action == 'pause') {
          _handleArbeitszeitPauseStart();
        }
      } else if (_arbeitszeitMode == ArbeitszeitButtonMode.stop) {
        _handlePauseStop();
      }
    });
  }

  void _handleArbeitszeitStart() {
    setState(() {
      _arbeitszeitMode = ArbeitszeitButtonMode.split;
      _fahrtzeitMode = ArbeitszeitButtonMode.start;

      _isArbeitszeitRunning = true;
      _arbeitszeitStartTime = DateTime.now();
      _pauseDuration = Duration.zero;
      _saveTimers();
    });
  }

  void _handleArbeitszeitPauseStart() {
    setState(() {
      _arbeitszeitMode = ArbeitszeitButtonMode.stop;
      _isPauseRunning = true;
      _pauseStartTime = DateTime.now();
      _saveTimers();
    });
  }

  void _handleArbeitszeitStop() {
    setState(() {
      _arbeitszeitMode = ArbeitszeitButtonMode.start;
      _isArbeitszeitRunning = false;
      _arbeitszeitDuration +=
          DateTime.now().difference(_arbeitszeitStartTime!) - _pauseDuration;
      _arbeitszeitStartTime = null;
      _saveTimers();
    });
  }

  void _handlePauseStop() {
    setState(() {
      _arbeitszeitMode = ArbeitszeitButtonMode.split;
      _isPauseRunning = false;
      _pauseDuration += DateTime.now().difference(_pauseStartTime!);
      _pauseStartTime = null;
      _saveTimers();
    });
  }

  // --------------------------------------------

  void _handleFahrtzeitPress() {
    setState(() {
      if (_fahrtzeitMode == ArbeitszeitButtonMode.start) {
        _handleFahrtzeitStart();
      } else {
        _handleFahrtzeitStop();
      }
    });
  }

  void _handleFahrtzeitStart() {
    setState(() {
      _fahrtzeitMode = ArbeitszeitButtonMode.stop;
      _arbeitszeitMode = ArbeitszeitButtonMode.start;

      _isFahrtzeitRunning = true;
      _fahrtzeitStartTime = DateTime.now();
      _saveTimers();
    });
  }

  void _handleFahrtzeitStop() {
    setState(() {
      _fahrtzeitMode = ArbeitszeitButtonMode.start;
      _isFahrtzeitRunning = false;
      _fahrtzeitDuration += DateTime.now().difference(_fahrtzeitStartTime!);
      _fahrtzeitStartTime = null;
      _saveTimers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding =
        MediaQuery.of(context).size.width * 0.1; // 10% padding

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            AufgabenButton(
              tasks: _dummyTasks,
              onTaskSelected: _onTaskSelected,
              initialTask: _currentTask,
            ),

            // Arbeitszeit Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _isPauseRunning
                      ? "Arbeitszeit: ${_formatDuration(_arbeitszeitDuration)}"
                      : "Arbeitszeit",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            ArbeitszeitButton(
              buttonText: _isArbeitszeitRunning
                  ? "Pause beenden"
                  : "Arbeitszeit starten",
              secondaryText: _pauseDuration != Duration.zero
                  ? _isPauseRunning
                      ? "Pause: ${_formatDuration(_pauseDuration)}"
                      : _arbeitszeitDuration != Duration.zero
                          ? "Arbeitszeit: ${_formatDuration(_arbeitszeitDuration)}"
                          : "Starte deine Arbeitszeit"
                  : _arbeitszeitMode == ArbeitszeitButtonMode.deactivated
                      ? "Wähle eine Aufgabe"
                      : "Arbeitszeit: ${_formatDuration(_arbeitszeitDuration)}",
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
              buttonText:
                  _isFahrtzeitRunning ? "Fahrt stoppen" : "Fahrt starten",
              secondaryText: _fahrtzeitDuration != Duration.zero
                  ? "Fahrt ${_formatDuration(_fahrtzeitDuration)}"
                  : _fahrtzeitMode == ArbeitszeitButtonMode.deactivated
                      ? "Wähle eine Aufgabe"
                      : "Starte deine Fahrtzeit",
              mode: _fahrtzeitMode,
              onPressed: _handleFahrtzeitPress,
              onStopPressed: _handleFahrtzeitPress,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
