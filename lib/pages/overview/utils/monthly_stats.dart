import 'package:ttfrontend/pages/overview/utils/overview_logic.dart';
import 'package:ttfrontend/service/api_service.dart';
import 'package:ttfrontend/service/models/graphql_query.dart';
import 'package:ttfrontend/service/models/task.dart';
import 'package:ttfrontend/service/models/graphql_response.dart';

class MonthlyStats {
  
  final ApiService _apiService = ApiService();

  // Helper function to calculate time difference
  String _calculateTimeDifference(List<TimeEntry> timers) {
    int totalMinutes = 0;
    for (var timer in timers) {
      totalMinutes += timer.endTime.difference(timer.startTime).inMinutes;
    }

    final int hours = totalMinutes ~/ 60;
    final int minutes = totalMinutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} h';
  }

  // Fetch all timers for the month and filter by type
  Future<Map<String, String>> getMonthlyStats(String yearMonth) async {
    const String query = r'''
      query TimersInBoundary($lowerBound: DateTime!, $upperBound: DateTime!) {
        timersInBoundary(lowerBound: $lowerBound, upperBound: $upperBound) {
          startTime
          endTime
          workType
          worktimeId
          task {
            taskId
            taskDescription
          }
        }
      }
    ''';

    final String lowerBound = OverviewLogic.formatDateTimeString(
        yearMonth.split('-')[0], yearMonth.split('-')[1], '01', '00:00:00');
    final String upperBound = OverviewLogic.formatDateTimeString(
        yearMonth.split('-')[0],
        (int.parse(yearMonth.split('-')[1]) + 1).toString().padLeft(2, '0'),
        '01',
        '00:00:00');

    try {
      GraphQLQuery graphQLQuery = GraphQLQuery(
        query: query,
        variables: {
          'lowerBound': lowerBound,
          'upperBound': upperBound,
        },
      );

      GraphQLResponse response = await _apiService.graphQLRequest(graphQLQuery);

      final List<TimeEntry> entries = [];
      if (response.data != null) {
        final timers = response.data?['data']?['timersInBoundary'];
        if (timers != null) {
          for (var timer in timers) {
            final DateTime startTime = DateTime.parse(timer['startTime']);
            final DateTime endTime = DateTime.parse(timer['endTime']);

            entries.add(TimeEntry(
              startTime: startTime,
              endTime: endTime,
              type: OverviewLogic.translateTypeToGerman(timer['workType']),
              worktimeId: timer['worktimeId'],
              activity: Task(
                  id: timer['task']['taskId'],
                  name: timer['task']['taskDescription']),
            ));
          }
        }
      }
      final List<TimeEntry> worktimeTimers =
          entries.where((timer) => timer.type == 'Arbeitszeit').toList();
      final List<TimeEntry> drivetimeTimers =
          entries.where((timer) => timer.type == 'Fahrtzeit').toList();

      return {
        'worktime': _calculateTimeDifference(worktimeTimers),
        'drivetime': _calculateTimeDifference(drivetimeTimers),
        'totalTime': _calculateTimeDifference(entries),
      };
    } catch (e) {
      return {
        'worktime': '00:00 h',
        'drivetime': '00:00 h',
        'totalTime': '00:00 h',
      };
    }
  }
}
