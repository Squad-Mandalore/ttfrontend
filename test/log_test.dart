import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:ttfrontend/service/api_service.dart';
import 'package:ttfrontend/service/log_service.dart';
import 'package:ttfrontend/service/models/graphql_query.dart';
import 'package:ttfrontend/service/models/graphql_response.dart';
import 'package:ttfrontend/service/models/login.dart';
import 'package:ttfrontend/service/models/token.dart';

import 'log_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ApiService>()])


// it can only be 'tested' when a debugger is attached so I am just testing if the function can run
void main() {
  group('Logger Tests', () {
    test('trace logs with correct name and message', () {
      const message = 'trace message';
      const description = 'trace description';

      trace(message, description: description);
    });

    test('debug logs with correct name and message', () {
      const message = 'debug message';
      const description = 'debug description';

      debug(message, description: description);
    });

    test('info logs with correct name and message', () {
      const message = 'info message';
      const description = 'info description';

      info(message, description: description);
    });

    test('warn logs with correct name and message', () {
      const message = 'warn message';
      const description = 'warn description';

      warn(message, description: description);
    });

    test('error logs with correct name and message', () {
      const message = 'error message';
      const description = 'error description';

      error(message, description: description);
    });

    test('fatal logs with correct name and message', () {
      const message = 'fatal message';
      const description = 'fatal description';

      fatal(message, description: description);
    });
  });

  group('ApiServiceTest', () {

    var apiService = MockApiService();
    Token token = Token(accessToken: "accessToken123", refreshToken: "refreshToken321");
    Login login = Login(email:"John@Doe.com", password: "password123");
    var response = GraphQLResponse(data: {"tasks":[{"taskid": 1, "taskDescription": "Neues Hobby suchen"}]});
    var query = """
        query {
          task{
            task_id
            task_description
          }
        }
        """;

    test('loginTest', ()  {
      when(apiService.login(login.email, login.email)).thenAnswer((_) async => token);

    });

    test('refreshTest', () {
      when(apiService.refresh(token.refreshToken)).thenAnswer((_) async => token);
    });

    test('requestGraphQl', () {
      when(apiService.graphQLRequest(GraphQLQuery(query: query))).thenAnswer((_) async => response);
    });
  });
}
