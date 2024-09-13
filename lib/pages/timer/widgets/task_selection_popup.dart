import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/service/models/task.dart';

class TaskSelectionPopup extends StatelessWidget {
  final Function(Task) onTaskSelected;
  final List<Task> tasks;

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
                            color: theme.colorScheme.onSurface,
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
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                    height: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(globalPadding),
                      child: tasks.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.assignment,
                                    size: 64,
                                    color: theme.colorScheme.primary
                                        .withOpacity(0.7),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Keine Aufgaben gefunden',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.7),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Aufgaben können in der Aufgabenansicht angelegt werden',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.5),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                // Task items with shadow, padding, and truncation
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      onTaskSelected(tasks[index]);
                                    },
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color:
                                            customColors?.backgroundAccent1 ??
                                                theme.colorScheme.primary,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
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
                                              String displayText =
                                                  tasks[index].name;

                                              final TextPainter textPainter =
                                                  TextPainter(
                                                text: TextSpan(
                                                  text: displayText,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: theme
                                                        .colorScheme.onSurface,
                                                  ),
                                                ),
                                                maxLines: 1,
                                                textDirection:
                                                    TextDirection.ltr,
                                              )..layout(
                                                      maxWidth: availableWidth);

                                              if (textPainter
                                                  .didExceedMaxLines) {
                                                // Truncate text based on available width
                                                final int cutoff = textPainter
                                                    .getPositionForOffset(
                                                        Offset(
                                                            availableWidth - 20,
                                                            0))
                                                    .offset;
                                                displayText =
                                                    '${tasks[index].name.substring(0, cutoff)}...';
                                              }

                                              return Text(
                                                displayText,
                                                style: TextStyle(
                                                  color: theme
                                                      .colorScheme.onSurface,
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
                            color: theme.colorScheme.onSurface,
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
