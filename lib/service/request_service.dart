import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendRequest() async {
  var url = Uri.parse('http://localhost:3000/');
  var headers = {
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Connection': 'keep-alive',
    'DNT': '1',
    'Origin': 'http://localhost:3000',
  };
  var query = '''
    query GetInfo(\$logMessage: String!) {
      info(logMessage: \$logMessage)
    }
  ''';
  var data = {
    'query': query,
    'variables': {'logMessage': 'meow'}
  };

  try {
    var response = await http.post(
      url,
      headers: headers,
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'), // Ensure proper encoding
    );

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}
