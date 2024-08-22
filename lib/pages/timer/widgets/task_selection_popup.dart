import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';

class TaskSelectionPopup extends StatelessWidget {
  final Function(String) onTaskSelected;
  final List<String> tasks;

  const TaskSelectionPopup({
    super.key,
    required this.onTaskSelected,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    const double globalPadding = 16.0;

    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).padding.top + kToolbarHeight + 10,
          bottom: 80 + 10,
          left: 10,
          right: 10,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: customColors?.popupBackgroundColor ??
                    theme.colorScheme.surface,
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
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: globalPadding,
                        left: globalPadding,
                        right: globalPadding,
                        bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aufgaben',
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey[300],
                    height: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: globalPadding),
                      child: ListView.builder(
                        itemCount:
                            tasks.length + 1, // Add one for the new task button
                        itemBuilder: (context, index) {
                          if (index == tasks.length) {
                            // "New Task" Button
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  // New task logic
                                },
                                child: DottedBorder(
                                  color: customColors?.backgroundAccent2 ??
                                      theme.colorScheme.surface,
                                  strokeWidth: 2,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(8),
                                  dashPattern: const [6, 3],
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color:
                                            customColors?.backgroundAccent2 ??
                                                theme.colorScheme.surface,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          // Task items with shadow, padding, and truncation
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                onTaskSelected(tasks[index]);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: customColors?.primaryAccent2 ??
                                      theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: globalPadding),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        final availableWidth =
                                            constraints.maxWidth;
                                        String displayText = tasks[index];

                                        final TextPainter textPainter =
                                            TextPainter(
                                          text: TextSpan(
                                            text: displayText,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                          maxLines: 1,
                                          textDirection: TextDirection.ltr,
                                        )..layout(maxWidth: availableWidth);

                                        if (textPainter.didExceedMaxLines) {
                                          // Truncate text based on available width
                                          final int cutoff = textPainter
                                              .getPositionForOffset(Offset(
                                                  availableWidth - 20, 0))
                                              .offset;
                                          displayText =
                                              '${tasks[index].substring(0, cutoff)}...';
                                        }

                                        return Text(
                                          displayText,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(globalPadding),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        child: Text(
                          'Abbrechen',
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
