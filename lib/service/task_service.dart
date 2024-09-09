import 'package:ttfrontend/pages/aufgaben/tasks.dart';

List<Task> getTasks() {
  return [
    Task(id: '1', name: 'Test Task'),
    Task(id: '2', name: 'Test Task 2'),
    Task(id: '3', name: 'Test Task 3'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
    Task(id: '4', name: 'Test Task 4 with a very long title'),
  ];
}

Task createTask(String newTaskName) {
  return Task(id: DateTime.now().toString(), name: newTaskName);
}

Task? removeTask(String id) {
  return null;
}

Task? updateTask(String id, String newTaskName) {
  return null;
}
