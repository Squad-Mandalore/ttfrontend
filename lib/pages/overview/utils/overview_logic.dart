import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class OverviewLogic {
  static List<String> getMonthsInGerman({bool forCurrentYear = false}) {
    List<String> allMonths = [
      'Januar',
      'Februar',
      'März',
      'April',
      'Mai',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Dezember',
    ];

    if (forCurrentYear) {
      int currentMonth = DateTime.now().month;
      return allMonths.sublist(0, currentMonth);
    }

    return allMonths;
  }

  static List<String> getYears() {
    int currentYear = DateTime.now().year;
    List<String> years = List<String>.generate(currentYear - 2019, (index) => (2020 + index).toString());
    years = years.reversed.toList();
    return years;
  }

  static Future<String> getCurrentMonthInGerman() async {
    await initializeDateFormatting('de');
    return DateFormat.MMMM('de').format(DateTime.now());
  }

  static Future<String> getCurrentYear() async {
    await initializeDateFormatting('en_US');
    return DateFormat.y().format(DateTime.now());
  }

  static List<String> getDaysInGerman(int year, int month) {
    initializeDateFormatting('de');
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(year, month + 1, 0).day;

    List<String> days = [];
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(year, month, day);
      if (year == now.year && month == now.month && day > now.day) break;

      String weekdayName = DateFormat.EEEE('de').format(date);
      String formattedDay = day.toString().padLeft(2, '0');
      days.add('$formattedDay. $weekdayName');
    }
    return days;
  }
}
