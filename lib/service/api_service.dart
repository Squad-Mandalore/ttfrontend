import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttfrontend/service/models/graphql_query.dart';
import 'package:ttfrontend/service/models/graphql_response.dart';
import 'models/login.dart';
import 'models/token.dart';

class ApiService {
  /* For testing purpose -> localhost unknown for emulator use local ip */
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
    try {
      headers.addAll({""'Authorization': 'Bearer ${token!.accessToken}'});
      var response = await http.post(
        Uri.parse('$baseurl/graphql'),
        headers: headers,
        body: json.encode(query),
        encoding: Encoding.getByName('utf-8'), // Ensure proper encoding
      );

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        return GraphQLResponse(data: jsonDecode(response.body));
      } else {
        throw Exception('Request Error ${response.statusCode}');
      }
    } catch (e) {
      throw('An error occurred: $e');
    }
  }

}