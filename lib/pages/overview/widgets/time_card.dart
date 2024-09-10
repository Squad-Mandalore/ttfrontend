import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/pages/overview/utils/overview_logic.dart';
import 'package:ttfrontend/pages/overview/utils/overview_popup_logic.dart';
import 'package:ttfrontend/pages/tasks/tasks.dart';

class TimeCard extends StatelessWidget {
  final TimeEntry entry;
  final String id;

  const TimeCard({
    super.key,
    required this.entry,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: customColors?.backgroundAccent3 ?? theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${entry.hours.toString().padLeft(2, '0')}:${entry.minutes.toString().padLeft(2, '0')} h',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    OverviewPopupLogic.showEditPopup(
                      context,
                      entry,
                      (editedEntry) {
                        // Handle edit action here
                      },
                      [Task(name: "Task 1", id: '1'), Task(name: "Task 1", id: '1')],
                    );
                  },
                  icon: const Icon(Icons.edit_outlined),
                   style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(customColors?.backgroundAccent5 ?? theme.colorScheme.surface),
                    minimumSize: WidgetStateProperty.all(const Size(37, 37)),
                  ),
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 20,
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    OverviewPopupLogic.showDeleteConfirmation(context, () {
                      // Add edit functionality here
                    });
                  },
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.white,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                    minimumSize: WidgetStateProperty.all(const Size(37, 37)),
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 40,
                  iconSize: 20,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    entry.type,
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                entry.type == 'Pause'
                    ? const Spacer()
                    : 
                Flexible(
                  child: Text(
                    entry.activity,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
