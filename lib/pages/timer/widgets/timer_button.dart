import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';

enum ArbeitszeitButtonMode { start, split, stop }

class ArbeitszeitButton extends StatelessWidget {
  final ArbeitszeitButtonMode mode;
  final String buttonText;
  final String secondaryText;
  final VoidCallback onPressed;
  final VoidCallback? onPausePressed; // For split mode
  final VoidCallback? onStopPressed; // For split mode

  const ArbeitszeitButton({
    super.key,
    required this.mode,
    required this.buttonText,
    required this.secondaryText,
    required this.onPressed,
    this.onPausePressed,
    this.onStopPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main Button or Split Buttons depending on mode
        if (mode == ArbeitszeitButtonMode.start ||
            mode == ArbeitszeitButtonMode.stop)
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              color: mode == ArbeitszeitButtonMode.stop
                  ? customColors?.primaryAccent3 ??
                      theme.colorScheme.error // Warning mode color
                  : theme.colorScheme.primary, // Button color from theme
            ),
            child: MaterialButton(
              onPressed: onPressed,
              height: 144, // Fixed height of 60px
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        else if (mode == ArbeitszeitButtonMode.split)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width *
                    0.4), // Half width for each button
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(0),
                  ),
                  color: customColors?.primaryAccent3 ??
                      Colors.red, // Color for stop button
                ),
                child: MaterialButton(
                  onPressed: onStopPressed,
                  height: 144, // Fixed height of 60px
                  child: const Text(
                    'Stop',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width *
                    0.4), // Half width for each button
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(0),
                    ),
                    color: customColors?.primaryAccent5 ??
                        Colors.redAccent // Color for pause button
                    ),
                child: MaterialButton(
                  onPressed: onPausePressed,
                  height: 144, // Fixed height of 60px
                  child: const Text(
                    'Pause',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        // Secondary field with drop shadow, slightly overlapping the main button
        Transform.translate(
          offset: const Offset(0, -8), // Move the container upwards by 8 pixels
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.fromLTRB(
                16, 22, 16, 16), // Padding inside the field
            decoration: BoxDecoration(
              color:
                  customColors?.primaryAccent7 ?? theme.colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 4), // Move shadow down
                ),
              ],
            ),
            child: Text(
              secondaryText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }
}
