import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ttfrontend/pages/login/login.dart';
import 'package:ttfrontend/service/models/graphql_query.dart';
import 'package:ttfrontend/service/models/graphql_response.dart';
import 'package:ttfrontend/service/navigation_service.dart';
import 'models/login.dart';
import 'models/token.dart';

class ApiService {
  /* For testing purpose -> localhost unknown for emulator use local ip */
  // Prod: https://magenta.jetzt/ttapi
  // IOS IP: http://127.0.0.1:3000
  // Android IP:
  var baseurl = Uri.parse('https://magenta.jetzt/ttapi');

  /* static saved token */
  static Token? token;

  /* common headers vor request */
  var headers = {
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Connection': 'keep-alive',
    'DNT': '1',
    'Origin': 'https://magenta.jetzt',
  };

  /// Request access and refresh token with [email] and [password]
  /// response [Token]
  Future<Token> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseurl/login'),
      headers: headers,
      body: jsonEncode(Login(email: email, password: password)),
    );

    if (response.statusCode == 200) {
      return token = Token.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed with status code: ${response.statusCode}');
    }
  }

  /// Request access and refresh token with [refreshToken]
  /// response [Token.refreshToken]
  Future<Token> refresh(String refreshToken) async {
    final response = await http.post(
      Uri.parse('$baseurl/refresh'),
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

  /// Request to the GraphQL endpoint with [GraphQLQuery] object,
  /// response -> [GraphQLResponse]
  /// Do know, that there are no hardcoded models (e.g. worktime, employee ...)
  /// and Query's / Mutations need to be tested
  Future<GraphQLResponse> graphQLRequest(GraphQLQuery query) async {
    if (token == null) {
      logout();
      throw Exception('Unauthorized after normal usage, how did this even happen?');
    }
    var response = await sendRequest(query);
    if (response == null) {
      token = await refresh(token!.refreshToken);
      if (token != null) {
        response = await sendRequest(query);
        if (response == null) {
          logout();
          throw Exception('Unauthorized after token refresh, logging out');
        }
      } else {
        throw Exception('Token refresh failed');
      }
    }
    return response;
  }

  Future<GraphQLResponse?> sendRequest(GraphQLQuery query) async {
    try {
      headers.addAll({'Authorization': 'Bearer ${token!.accessToken}'});
      var response = await http.post(
        Uri.parse('$baseurl/graphql'),
        headers: headers,
        body: json.encode(query),
        encoding: Encoding.getByName('utf-8'),
      );
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        return GraphQLResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      } else if (response.statusCode == 401) {
        // Return null to indicate a need for token refresh
        return null;
      } else {
        throw Exception('Request Error ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  static logout() {
    BuildContext context = NavigationService.navigatorKey.currentContext!;
    if (Navigator.of(context).mounted) {
      token = null;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erfolgreich Ausgeloggt!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        ModalRoute.withName('/'),
      );
    }
  }
}
