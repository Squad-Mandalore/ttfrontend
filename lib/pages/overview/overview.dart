import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ttfrontend/assets/colours/extended_theme.dart';
import 'package:ttfrontend/pages/overview/utils/overview_logic.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  OverviewPageState createState() => OverviewPageState();
}

class OverviewPageState extends State<OverviewPage> with SingleTickerProviderStateMixin {
  // Dropdown state for month and year
  String? selectedMonth;
  String? selectedYear;
  String? currentYear;

  // Switching logic state
  bool isDayViewSelected = true;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initializeDefaults();

    // Initialize the animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300), // Reduced duration for a quicker transition
      vsync: this,
    );

    // Define the animation curve without bounce effect
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
  }

  Future<void> _initializeDefaults() async {
    String month = await OverviewLogic.getCurrentMonthInGerman();
    String year = await OverviewLogic.getCurrentYear();
    setState(() {
      selectedMonth = month;
      selectedYear = year;
      currentYear = year;
    });
  }

  void _onViewSelected(bool isDayView) {
    if (isDayViewSelected != isDayView) {
      setState(() {
        isDayViewSelected = isDayView;
        _animationController.reset();
        _animationController.forward();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const double globalPadding = 30.0;

    bool isCurrentYear = selectedYear == currentYear;

    return Padding(
      padding: const EdgeInsets.only(
          left: globalPadding,
          right: globalPadding,
          bottom: globalPadding,
          top: 50.0),
      child: Column(
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
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue!;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
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
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue!;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
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
                    // Underline that shows under both buttons
                    Container(
                      height: 2.0,
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                    ),
                    // Animated line under the selected button
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Align(
                          alignment: Alignment(
                              _animation.value * (isDayViewSelected ? -1 : 1),
                              0.0),
                          child: Container(
                            height: 2.0,
                            width: MediaQuery.of(context).size.width / 2 - globalPadding,
                            color: theme.colorScheme.primary,
                          ),
                        );
                      },
                    ),
                    // Text buttons placed above the animated line
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _onViewSelected(true),
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
                            onTap: () => _onViewSelected(false),
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
          const SizedBox(height: 16.0),
          // Content for Tagesansicht or Monatsansicht
          Expanded(
            child: isDayViewSelected
                ? Center(
                    child: Text(
                      'Tagesansicht Content',
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'Monatsansicht Content',
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
