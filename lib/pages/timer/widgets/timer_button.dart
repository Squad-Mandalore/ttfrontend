import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';

enum WorkTimeButtonMode { start, split, stop, deactivated }

class WorkTimeButton extends StatelessWidget {
  final WorkTimeButtonMode mode;
  final String buttonText;
  final String secondaryText;
  final VoidCallback? onPressed;
  final VoidCallback? onPausePressed;
  final VoidCallback? onStopPressed;

  const WorkTimeButton({
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
        if (mode == WorkTimeButtonMode.start ||
            mode == WorkTimeButtonMode.stop ||
            mode == WorkTimeButtonMode.deactivated)
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  color: mode == WorkTimeButtonMode.stop
                      ? customColors?.bigButtonStopColor ??
                          theme.colorScheme.error // Stop mode color
                      : customColors?.bigButtonColor ??
                          theme.colorScheme.primary, // Button color from theme
                ),
                child: MaterialButton(
                  onPressed:
                      mode == WorkTimeButtonMode.deactivated ? null : onPressed,
                  height: 144,
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
              ),
              if (mode == WorkTimeButtonMode.deactivated)
                Container(
                  height: 144, // Same height as the button
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4), // 40% black overlay
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
            ],
          )
        else if (mode == WorkTimeButtonMode.split)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width * 0.4),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(0),
                  ),
                  color: customColors?.bigButtonStopColor ??
                      Colors.red, // Color for stop button
                ),
                child: MaterialButton(
                  onPressed: onStopPressed,
                  height: 144, // Fixed height of 144px
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
                width: (MediaQuery.of(context).size.width * 0.4),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(0),
                    ),
                    color: customColors?.bigButtonPauseColor ??
                        Colors.redAccent // Color for pause button
                    ),
                child: MaterialButton(
                  onPressed: onPausePressed,
                  height: 144, // Fixed height of 144px
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
        // Highlight box below the button
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: customColors?.bigButtonHighlightBoxColor ??
                theme.colorScheme.secondary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.20),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            secondaryText,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
