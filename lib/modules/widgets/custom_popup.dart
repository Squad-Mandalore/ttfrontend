import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';

enum PopUpMode { warning, error, agree }

class GenericPopup extends StatelessWidget {
  final String title;
  final Widget content; // The entire body content of the popup is a widget
  final PopUpMode mode; // The mode of the popup
  final VoidCallback? onAgree; // Optional in case not needed
  final VoidCallback? onDisagree; // Optional in case not needed
  final String? cancleText; // Optional in case not needed
  final String? agreeText; // Optional in case not needed

  const GenericPopup({
    super.key,
    required this.title,
    required this.content,
    required this.mode,
    this.onAgree,
    this.onDisagree,
    this.cancleText,
    this.agreeText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();
    final mediaQuery = MediaQuery.of(context);

    const double globalPadding = 16.0;

    Color backgroundColor = mode == PopUpMode.error
        ? theme.colorScheme.surface
        : customColors?.popupBackgroundColor ?? theme.colorScheme.surface;

    double availableHeight = mediaQuery.size.height - 300;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: mediaQuery.size.width - 40,
          maxHeight: availableHeight,
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
              mainAxisSize: MainAxisSize.min,
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
                            cancleText ?? 'Abbrechen',
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
                                : const Color(0xFFDE1A1A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            agreeText != null
                                ? agreeText!
                                : mode == PopUpMode.agree
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

  static void showErrorPopup(BuildContext context, String errorMessage) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return GenericPopup(
            title: 'Error',
            agreeText: 'ok',
            content: Column(
              children: [
                const SizedBox(height: 16.0),
                Text(errorMessage),
                const SizedBox(height: 16.0),
              ],
            ),
            mode: PopUpMode.error,
            onAgree: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    }

  static void showWarningPopup(BuildContext context, String warningMessage, String title) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return GenericPopup(
            title: title,
            agreeText: 'ok',
            content: Column(
              children: [
                const SizedBox(height: 16.0),
                Text(warningMessage),
                const SizedBox(height: 16.0),
              ],
            ),
            mode: PopUpMode.warning,
            onAgree: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    }
}
