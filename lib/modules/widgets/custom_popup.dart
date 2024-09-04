import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';

enum PopUpMode { warning, error, agree }

class GenericPopup extends StatelessWidget {
  final String title;
  final Widget content; // The entire body content of the popup is a widget
  final PopUpMode mode; // The mode of the popup
  final VoidCallback? onAgree; // Optional in case not needed
  final VoidCallback? onDisagree; // Optional in case not needed

  const GenericPopup({
    super.key,
    required this.title,
    required this.content,
    required this.mode,
    this.onAgree,
    this.onDisagree,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();
    final mediaQuery = MediaQuery.of(context);

    const double globalPadding = 16.0;

    Color backgroundColor =
        customColors?.popupBackgroundColor ?? theme.colorScheme.surface;

    // Calculate the available height
    double availableHeight = mediaQuery.size.height - 300;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth:
              mediaQuery.size.width - 40, // Ensures left and right padding
          maxHeight:
              availableHeight, // Max height to prevent overlapping nav/app bars
          minHeight: 200,
        ),
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(globalPadding),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: customColors?.backgroundAccent10.withOpacity(0.3) ??
                      Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Shrinks to fit content
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Divider(
                  thickness: 1.5,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  height: 1,
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: content,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                if (onAgree != null || onDisagree != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (onDisagree != null)
                        TextButton(
                          onPressed: onDisagree,
                          child: Text(
                            'Abbrechen',
                            style: TextStyle(
                              color: theme.colorScheme.secondary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      const SizedBox(width: 8),
                      if (onAgree != null)
                        ElevatedButton(
                          onPressed: onAgree,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mode == PopUpMode.agree
                                ? theme.colorScheme.primary
                                : mode == PopUpMode.warning
                                    ? const Color.fromARGB(255, 223, 106, 11)
                                    : const Color(0xFFDE1A1A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            mode == PopUpMode.agree
                                ? 'Zustimmen'
                                : mode == PopUpMode.warning
                                    ? 'OK'
                                    : 'Mist',
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
