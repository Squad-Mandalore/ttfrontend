import 'package:ttfrontend/service/models/task.dart';

class TaskFilter {
  static List<Task> filterTasks(List<Task> tasks, String query) {
    if (query.isEmpty) {
      return tasks;
    } else {
      // Split the query into individual words
      final queryWords = query.toLowerCase().split(' ');

      return tasks.where((task) {
        final taskName = task.name.toLowerCase();

        // Check if the task name contains all the words in the query
        return queryWords.every((word) => taskName.contains(word));
      }).toList();
    }
  }
}
