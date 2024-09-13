import 'package:flutter/foundation.dart';
import 'package:ttfrontend/service/api_service.dart';
import 'package:ttfrontend/service/models/graphql_query.dart';
import 'package:ttfrontend/service/models/task.dart';

Future<Task?> createTask(String newTaskName) async {
  var createTask = r"""
    mutation($taskDescription: String!) {
      task: createTask(taskDescription: $taskDescription) {
        taskId
        taskDescription
      }
    }
    """;
  var response = await ApiService().graphQLRequest(GraphQLQuery(
      query: createTask, variables: {"taskDescription": newTaskName}));

  Map<String, dynamic>? taskJson = response.data?['task'] == null
      ? null
      : response.data?['task'] as Map<String, dynamic>;
  if (taskJson == null) {
    return Future<Task?>.value(null);
  }

  return compute(Task.fromJson, taskJson);
}

Future<List<Task>> fetchTasks() async {
  var queryTasks = """
    query {
      tasks{
        taskId
        taskDescription
      }
    }
    """;
  var response =
      await ApiService().graphQLRequest(GraphQLQuery(query: queryTasks));

  return compute(parseTasks, response.data?['tasks'] as List);
}

List<Task> parseTasks(List responseBody) {
  var parsed = responseBody.cast<Map<String, dynamic>>();
  return parsed.map<Task>((json) => Task.fromJson(json)).toList();
}

Future<Task?> removeTask(int id) async {
  var removeTask = r"""
    mutation($taskId: Int!){
      task: deleteTask(taskId: $taskId){
        taskId
        taskDescription
      }
    }
    """;
  var response = await ApiService().graphQLRequest(
      GraphQLQuery(query: removeTask, variables: {"taskId": id}));

  Map<String, dynamic>? taskJson = response.data?['task'] == null
      ? null
      : response.data?['task'] as Map<String, dynamic>;
  if (taskJson == null) {
    return Future<Task?>.value(null);
  }

  return compute(Task.fromJson, taskJson);
}

Future<Task?> updateTask(int id, String newTaskName) async {
  var updateTask = r"""
    mutation($taskId: Int!, $taskDescription: String!){
      task: updateTask(taskId: $taskId, taskDescription: $taskDescription){
        taskId
        taskDescription
      }
    }
    """;
  var response = await ApiService().graphQLRequest(GraphQLQuery(
      query: updateTask,
      variables: {"taskId": id, "taskDescription": newTaskName}));

  Map<String, dynamic>? taskJson = response.data?['task'] == null
      ? null
      : response.data?['task'] as Map<String, dynamic>;
  if (taskJson == null) {
    return Future<Task?>.value(null);
  }

  return compute(Task.fromJson, taskJson);
}
