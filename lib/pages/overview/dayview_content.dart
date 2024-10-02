import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/pages/overview/utils/overview_logic.dart';
import 'package:ttfrontend/pages/overview/utils/daily_logic.dart';
import 'package:ttfrontend/pages/overview/widgets/time_card.dart';

class DayviewContent extends StatefulWidget {
  final String? selectedMonth;
  final String? selectedYear;
  final String? selectedDay;
  final Function(String?) onDayChanged;

  const DayviewContent({
    super.key,
    this.selectedMonth,
    this.selectedYear,
    this.selectedDay,
    required this.onDayChanged,
  });

  @override
  DayviewContentState createState() => DayviewContentState();
}

class DayviewContentState extends State<DayviewContent> {
  Future<List<TimeEntry>> _fetchTimers() async {
    final dailyLogic = DailyLogic();
    if (widget.selectedYear == null ||
        widget.selectedMonth == null ||
        widget.selectedDay == null) {
      return [];
    }

    return await dailyLogic.getTimersForDay(
        widget.selectedYear!, widget.selectedMonth!, widget.selectedDay!);
  }

  void _reloadTimers() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();

    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            barrierColor: theme.colorScheme.onSurface.withOpacity(0.1),
            isExpanded: true,
            hint: Text(
              'Tag auswählen',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: widget.selectedMonth != null && widget.selectedYear != null
                ? OverviewLogic.getDaysInGerman(
                        int.parse(widget.selectedYear!),
                        OverviewLogic.getMonthsInGerman()
                                .indexOf(widget.selectedMonth!) +
                            1)
                    .map((String day) => DropdownMenuItem<String>(
                          value: day,
                          child: Text(
                            day,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList()
                : [],
            value: widget.selectedDay,
            onChanged: widget.onDayChanged,
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: customColors?.backgroundAccent3 ??
                    theme.colorScheme.surface,
                border: Border.all(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        // Scrollable list of time cards
        Expanded(
          child: FutureBuilder<List<TimeEntry>>(
            future: _fetchTimers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text('Es wurden keine Timer gefunden'));
              }

              final timers = snapshot.data!;

              return ListView.builder(
                itemCount: timers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TimeCard(
                      entry: timers[index],
                      id: '$index',
                      onUpdate: _reloadTimers,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
