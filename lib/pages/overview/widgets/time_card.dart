import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';

class TimeCard extends StatelessWidget {
  final int hours;
  final int minutes;
  final String type;
  final String activity;
  final String id;

  const TimeCard({
    super.key,
    required this.hours,
    required this.minutes,
    required this.type,
    required this.activity,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    return Card(
      color: customColors?.backgroundAccent3 ?? theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} h',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // Add edit functionality here
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(customColors?.backgroundAccent5 ?? theme.colorScheme.surface),
                    minimumSize: WidgetStateProperty.all(const Size(37, 37)),
                  ),
                  icon: const Icon(Icons.edit),
                  color: theme.colorScheme.onSurface,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 20,
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    // Add delete functionality here
                  },
                  icon: const Icon(Icons.delete),
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
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                type,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                ),
              ),
              Flexible(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                  activity,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                  ),
                  ),
                ],
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
