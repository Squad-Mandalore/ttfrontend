import 'package:ttfrontend/service/api_service.dart';
import 'package:ttfrontend/service/models/graphql_query.dart';
import 'package:ttfrontend/service/models/graphql_response.dart';
import 'package:ttfrontend/pages/overview/utils/overview_logic.dart';
import 'package:ttfrontend/service/models/task.dart';


class DailyLogic {
  final ApiService _apiService = ApiService();

  // Fetch timers for a specific day
  Future<List<TimeEntry>> getTimersForDay(
      String year, String month, String day) async {
    const String query = r'''
      query TimersInBoundary($lowerBound: DateTime!, $upperBound: DateTime!) {
        timersInBoundary(lowerBound: $lowerBound, upperBound: $upperBound) {
          startTime
          endTime
          workType
          worktimeId
          task {
            taskDescription
            taskId
          }
        }
      }
    ''';
    day = day.split('.').first;
    String yearMonth = OverviewLogic.formatMonthYearForBackend(month, year);
    final String lowerBound = OverviewLogic.formatDateTimeString(
        yearMonth.split('-')[0], yearMonth.split('-')[1], day, '00:00:00');
    final String upperBound = OverviewLogic.formatDateTimeString(
        yearMonth.split('-')[0], yearMonth.split('-')[1], day, '23:59:59');

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
        final timers = response.data?['timersInBoundary'];
        if (timers != null) {
          for (var timer in timers) {
            final DateTime startTime = DateTime.parse(timer['startTime']);
            final DateTime endTime = DateTime.parse(timer['endTime']);

            entries.add(TimeEntry(
              startTime: startTime,
              endTime: endTime,
              type: OverviewLogic.translateTypeToGerman(timer['workType']),
              activity: Task(
                  id: timer['task']['taskId'],
                  name: timer['task']['taskDescription']),
              worktimeId: timer['worktimeId'],
            ));
          }
        }
      }
      return entries;
    } catch (e) {
      throw Exception('Failed to fetch timers for the day: $e');
    }
  }

// Edit a timer
  Future<TimeEntry> editTimer(TimeEntry timeEntry) async {
    const String query = r'''
      mutation updateTimer($worktimeId: Int!, $startTime: DateTime!, $endTime: DateTime!, $worktype: String!, $taskId: Int!) {
        updateTimer(worktimeId: $worktimeId, startTime: $startTime, endTime: $endTime, worktype: $worktype, taskId: $taskId) {
          worktimeId
        }
      }
    ''';

    try {
      GraphQLQuery graphQLQuery = GraphQLQuery(
        query: query,
        variables: {
          'worktimeId': timeEntry.worktimeId,
          'startTime': OverviewLogic.formatDateTime(timeEntry.startTime),
          'endTime': OverviewLogic.formatDateTime(timeEntry.endTime),
          'worktype': OverviewLogic.translateTypeToEnglish(timeEntry.type),
          'taskId': timeEntry.activity.id,
        },
      );

      await _apiService.graphQLRequest(graphQLQuery);
    } catch (e) {
      throw Exception('Failed to edit timer: $e');
    }
    return timeEntry;
  }

  // Edit a timer and reload all timers for the day
  Future<List<TimeEntry>> editTimerAndReload(
      TimeEntry timeEntry, String year, String month) async {
    // First, edit the timer
    await editTimer(timeEntry);

    // Extract the day from startTime
    String day = timeEntry.startTime.day.toString().padLeft(2, '0');

    // Then, reload all timers for the day
    return await getTimersForDay(year, month, day);
  }
}
