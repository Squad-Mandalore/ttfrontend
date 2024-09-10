import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/pages/overview/utils/overview_logic.dart';
import 'package:ttfrontend/pages/overview/widgets/time_card.dart';

class TagesansichtContent extends StatelessWidget {
  final String? selectedMonth;
  final String? selectedYear;
  final String? selectedDay;
  final Function(String?) onDayChanged;

  const TagesansichtContent({
    super.key,
    this.selectedMonth,
    this.selectedYear,
    this.selectedDay,
    required this.onDayChanged,
  });

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
              'Select Day',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: selectedMonth != null && selectedYear != null
                ? OverviewLogic.getDaysInGerman(
                        int.parse(selectedYear!),
                        OverviewLogic.getMonthsInGerman()
                                .indexOf(selectedMonth!) +
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
            value: selectedDay,
            onChanged: onDayChanged,
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
          child: ListView.builder(
            itemCount: 10, // TODO: Replace with actual data count
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TimeCard(
                  entry: TimeEntry(
                    hours: index + 1,
                    minutes: (index * 10) % 60,
                    type: index % 2 == 0 ? 'Arbeitszeit' : 'Pause',
                    activity: 'Activity $index',
                  ),
                  id: '$index',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
