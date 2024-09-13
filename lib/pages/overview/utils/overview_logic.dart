import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttfrontend/service/models/task.dart';

class TimeEntry {
  DateTime startTime;
  DateTime endTime;
  String type;
  Task activity;
  int worktimeId;

  TimeEntry({
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.activity,
    required this.worktimeId,
  });
}

class OverviewLogic {
  static List<String> allMonths = [
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
  // Helper function to manually format DateTime strings
  static String formatDateTimeString(
      String year, String month, String day, String time) {
    return '$year-${month.padLeft(2, '0')}-${day.padLeft(2, '0')}T$time' 'Z';
  }

  static String formatDateTime(DateTime dateTime) {
    return '${DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime)}Z';
  }

  static List<String> getMonthsInGerman({bool forCurrentYear = false}) {
    if (forCurrentYear) {
      int currentMonth = DateTime.now().month;
      return allMonths.sublist(0, currentMonth);
    }

    return allMonths;
  }

  static List<String> getYears() {
    int currentYear = DateTime.now().year;
    List<String> years = List<String>.generate(
        currentYear - 2019, (index) => (2020 + index).toString());
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
    return days.reversed.toList();
  }

  static String formatMonthYearForBackend(String month, String year) {
    int? monthIndex = allMonths.indexOf(month) + 1;
    if (monthIndex > 0) {
      String formattedMonth = monthIndex.toString().padLeft(2, '0');
      return '$year-$formattedMonth';
    }
    return '';
  }

  static String translateTypeToGerman(String type) {
    switch (type) {
      case 'BREAK':
        return 'Pause';
      case 'WORK':
        return 'Arbeitszeit';
      case 'RIDE':
        return 'Fahrtzeit';
      default:
        return 'Nicht mein typ';
    }
  }

  static String translateTypeToEnglish(String type) {
    switch (type) {
      case 'Pause':
        return 'BREAK';
      case 'Arbeitszeit':
        return 'WORK';
      case 'Fahrtzeit':
        return 'RIDE';
      default:
        return 'Not my type';
    }
  }

  static String getFormattedHoursAndMinutes(TimeEntry entry) {
    int hours = entry.endTime.difference(entry.startTime).inHours;
    int minutes = entry.endTime.difference(entry.startTime).inMinutes % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')} h';
  }

  static Future<String> getLastPdfRequest() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('lastPdfRequest') ?? 'Nie';
  }
}
