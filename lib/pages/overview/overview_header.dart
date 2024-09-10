import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/pages/overview/utils/overview_logic.dart';

class OverviewHeader extends StatelessWidget {
  final String? selectedMonth;
  final String? selectedYear;
  final bool isCurrentYear;
  final Function(String?) onMonthChanged;
  final Function(String?) onYearChanged;
  final Function(bool) onViewSelected;
  final bool isDayViewSelected;
  final AnimationController animationController;
  final Animation<double> animation;

  const OverviewHeader({
    super.key,
    this.selectedMonth,
    this.selectedYear,
    required this.isCurrentYear,
    required this.onMonthChanged,
    required this.onYearChanged,
    required this.onViewSelected,
    required this.isDayViewSelected,
    required this.animationController,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomThemeExtension>();
    const double globalPadding = 30.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Monatsauswahl',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  barrierColor: theme.colorScheme.onSurface.withOpacity(0.1),
                  isExpanded: true,
                  hint: Text(
                    'Select Month',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: OverviewLogic.getMonthsInGerman(
                          forCurrentYear: isCurrentYear)
                      .map((String month) => DropdownMenuItem<String>(
                            value: month,
                            child: Text(
                              month,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedMonth,
                  onChanged: onMonthChanged,
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
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              flex: 1,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  barrierColor: theme.colorScheme.onSurface.withOpacity(0.1),
                  hint: Text(
                    'Select Year',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: OverviewLogic.getYears()
                      .map((String year) => DropdownMenuItem<String>(
                            value: year,
                            child: Text(
                              year,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedYear,
                  onChanged: onYearChanged,
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
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30.0),
        Row(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 2.0,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return Align(
                        alignment: Alignment(
                            animation.value * (isDayViewSelected ? -1 : 1),
                            0.0),
                        child: Container(
                          height: 2.0,
                          width: MediaQuery.of(context).size.width / 2 -
                              globalPadding,
                          color: theme.colorScheme.primary,
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => onViewSelected(true),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Tagesansicht',
                              style: TextStyle(
                                fontSize: 18,
                                color: isDayViewSelected
                                    ? theme.colorScheme.onSurface
                                    : theme.colorScheme.onSurface
                                        .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => onViewSelected(false),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Monatsansicht',
                              style: TextStyle(
                                fontSize: 18,
                                color: !isDayViewSelected
                                    ? theme.colorScheme.onSurface
                                    : theme.colorScheme.onSurface
                                        .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 30.0),
      ],
    );
  }
}
