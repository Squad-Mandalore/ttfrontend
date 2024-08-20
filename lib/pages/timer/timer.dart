import 'package:flutter/material.dart';
import 'package:ttfrontend/pages/timer/widgets/timer_button.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  // States for the modes of the buttons
  ArbeitszeitButtonMode _arbeitszeitMode = ArbeitszeitButtonMode.start;
  ArbeitszeitButtonMode _fahrtzeitMode = ArbeitszeitButtonMode.start;

  // This function handles the transition logic for the Arbeitszeit button
  void _handleArbeitszeitPress(String action) {
    setState(() {
      if (_arbeitszeitMode == ArbeitszeitButtonMode.start) {
        _arbeitszeitMode = ArbeitszeitButtonMode.split; // Start → Split
        _fahrtzeitMode = ArbeitszeitButtonMode.start; // Start → Start
      } else if (_arbeitszeitMode == ArbeitszeitButtonMode.split) {
        if (action == 'stop') {
          _arbeitszeitMode = ArbeitszeitButtonMode.start; // Split → Start
        } else if (action == 'pause') {
          _arbeitszeitMode =
              ArbeitszeitButtonMode.stop; // Split → Warning (Pause Mode)
        }
      } else if (_arbeitszeitMode == ArbeitszeitButtonMode.stop) {
        _arbeitszeitMode =
            ArbeitszeitButtonMode.split; // Warning → Split (Pause beenden)
      }
    });
  }

  // This function handles the transition logic for the Fahrtzeit button
  void _handleFahrtzeitPress() {
    setState(() {
      if (_fahrtzeitMode == ArbeitszeitButtonMode.start) {
        _fahrtzeitMode = ArbeitszeitButtonMode.stop; // Start → Stop Mode
        _arbeitszeitMode = ArbeitszeitButtonMode.start; // Stop → Start Mode
      } else {
        _fahrtzeitMode = ArbeitszeitButtonMode.start; // Stop → Start Mode
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16.0), // Consistent padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
          children: [
            // Arbeitszeit Section
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 16.0), // Space above and below text
              child: Text(
                "Arbeitszeit",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface,
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
              padding: const EdgeInsets.symmetric(
                  vertical: 16.0), // Space above and below text
              child: Text(
                "Fahrtzeit",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface,
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
              onPausePressed: null, // No pause functionality for Fahrtzeit
              onStopPressed: _handleFahrtzeitPress, // Handle as stop
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 16.0), // Space above and below text
              child: Text(
                "Aufgabe",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
