import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'models/login.dart';
import 'models/token.dart';

class ApiService {
  /* For testing purpose -> localhost unknown for emulator use local ip */
  var baseurl = Uri.parse('http://192.168.178.89:3000');
  /* GraphQL HttpLink -> Different Object than baseUrl */
  final _httpLink = HttpLink('http://192.168.178.89:3000');
  /* static saved token */
  static Token? token;
  /* common headers vor request */
  var headers = {
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Connection': 'keep-alive',
    'DNT': '1',
    'Origin': 'http://localhost:3000',
  };

  void initGraphQL() async {
    await initHiveForFlutter();
    final authLink = AuthLink(getToken: () async => 'Bearer $token');
    final Link link = authLink.concat(_httpLink);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
        GraphQLClient(
            link: link,
            cache: GraphQLCache(store: HiveStore()),
        ),
    );
  }

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

}