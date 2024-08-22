import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/graphql_response.dart';
import 'models/login.dart';
import 'models/token.dart';
import 'models/graphql_query.dart';

class TimeTrackingApi {
  final String baseUrl;
  String? accessToken;

  TimeTrackingApi(this.baseUrl);

  Future<Token> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(Login(email: email, password: password)),
    );

    if (response.statusCode == 200) {
      return Token.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed with status code: ${response.statusCode}');
    }
  }

  Future<Token> refresh(String refreshToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      return Token.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Refresh failed with status code: ${response.statusCode}');
    }
  }

  Future<GraphQLResponse> graphql(String query,
      {Map<String, dynamic>? variables}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/graphql'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken', // Add Bearer token if available
      },
      body: jsonEncode(GraphQLQuery(query: query, variables: variables)),
    );

    if (response.statusCode == 200) {
      return GraphQLResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized. Access token might be invalid.');
    } else {
      throw Exception(
          'GraphQL request failed with status code: ${response.statusCode}');
    }
  }
}