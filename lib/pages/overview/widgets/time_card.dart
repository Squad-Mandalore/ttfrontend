import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/pages/overview/utils/daily_logic.dart';
import 'package:ttfrontend/pages/overview/utils/overview_logic.dart';
import 'package:ttfrontend/service/models/task.dart';
import 'package:ttfrontend/pages/overview/utils/overview_popup_logic.dart';

class TimeCard extends StatelessWidget {
  final TimeEntry entry;
  final String id;
  final VoidCallback onUpdate;

  const TimeCard({
    super.key,
    required this.entry,
    required this.id,
    required this.onUpdate,
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
                  OverviewLogic.getFormattedHoursAndMinutes(entry),
                  style: TextStyle(
                    fontSize: 20,
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
                      (editedEntry) async {
                        await DailyLogic().editTimer(editedEntry);
                        onUpdate(); // Call the callback to update the list
                      },
                      [
                        Task(name: "Task 1", id: 1),
                        Task(name: "Task 2", id: 2)
                      ],
                    );
                  },
                  icon: const Icon(Icons.edit_outlined),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        customColors?.backgroundAccent5 ??
                            theme.colorScheme.surface),
                    minimumSize: WidgetStateProperty.all(const Size(37, 37)),
                  ),
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 20,
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
                if (entry.type != 'Pause')
                  Flexible(
                    flex: 0,
                    child: Text(
                      entry.activity.name,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                const Padding(padding: EdgeInsets.only(right: 8.0))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
