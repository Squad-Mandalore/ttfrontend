import 'package:flutter/material.dart';
import 'package:ttfrontend/pages/overview/dayview_content.dart';
import 'package:ttfrontend/pages/overview/monthly_view.dart';
import 'package:ttfrontend/pages/overview/overview_header.dart';
import 'package:ttfrontend/pages/overview/utils/overview_logic.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  OverviewPageState createState() => OverviewPageState();
}

class OverviewPageState extends State<OverviewPage>
    with SingleTickerProviderStateMixin {
  String? selectedMonth;
  String? selectedYear;
  String? selectedDay;
  String? currentYear;

  bool isDayViewSelected = true; // Default to Dayview

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initializeDefaults();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.value = 0.0; // Ensure it starts aligned with Tagesansicht
  }

  Future<void> _initializeDefaults() async {
    String month = await OverviewLogic.getCurrentMonthInGerman();
    String year = await OverviewLogic.getCurrentYear();
    setState(() {
      selectedMonth = month;
      selectedYear = year;
      currentYear = year;
      _updateDaysDropdown();
    });
    setState(() {
        _animationController.reset();
        _animationController.forward();
      });
  }

  void _updateDaysDropdown() {
    if (selectedMonth != null && selectedYear != null) {
      int monthIndex =
          OverviewLogic.getMonthsInGerman().indexOf(selectedMonth!) + 1;
      int year = int.parse(selectedYear!);
      List<String> days = OverviewLogic.getDaysInGerman(year, monthIndex);
      setState(() {
        selectedDay = days.isNotEmpty ? days.first : null;
      });
    }
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            OverviewHeader(
              selectedMonth: selectedMonth,
              selectedYear: selectedYear,
              isCurrentYear: selectedYear == currentYear,
              animationController: _animationController,
              animation: _animation,
              onMonthChanged: (String? newValue) {
                setState(() {
                  selectedMonth = newValue;
                  _updateDaysDropdown();
                });
              },
              onYearChanged: (String? newValue) {
                setState(() {
                  selectedYear = newValue;
                  _updateDaysDropdown();
                });
              },
              onViewSelected: _onViewSelected,
              isDayViewSelected: isDayViewSelected,
            ),
            Expanded(
              child: isDayViewSelected
                  ? DayviewContent(
                      selectedMonth: selectedMonth,
                      selectedYear: selectedYear,
                      selectedDay: selectedDay,
                      onDayChanged: (String? newValue) {
                        setState(() {
                          selectedDay = newValue;
                        });
                      },
                    )
                  : MonthviewContent(
                      formattedMonthYear: OverviewLogic.formatMonthYearForBackend(selectedMonth ?? 'November', selectedYear ?? '2024'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
