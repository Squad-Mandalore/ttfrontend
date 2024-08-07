import 'package:test/test.dart';
import 'package:ttfrontend/service/log_service.dart';

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
}
