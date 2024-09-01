import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/graphql_response.dart';
import 'models/login.dart';
import 'models/token.dart';
import 'models/graphql_query.dart';

class ApiService {
  // For testing purpose -> localhost unknown for emulator
  // https://medium.com/@podcoder/connecting-flutter-application-to-localhost-a1022df63130
  var baseUrl = Uri.parse('http://192.168.178.89:3000');
  static Token? token;
  var headers = {
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Connection': 'keep-alive',
    'DNT': '1',
    'Origin': 'http://localhost:3000',
  };

  Future<Token> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: headers,
      body: jsonEncode(Login(email: email, password: password)),
    );

    if (response.statusCode == 200) {
      return token = Token.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed with status code: ${response.statusCode}');
    }
  }

  Future<Token> refresh(String refreshToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/refresh'),
      headers: headers,
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
        'Accept-Encoding': 'gzip, deflate, br',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'DNT': '1',
        'Origin': 'http://localhost:3000',
        'Authorization': 'bearer ${token?.accessToken}', // Add Bearer token if available
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