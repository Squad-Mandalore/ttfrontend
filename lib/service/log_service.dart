import 'dart:convert';
import 'dart:developer' as developer;

void trace(Object? message, {Object? description}) {
  developer.log(jsonEncode(message), name: 'TRACE', error: description);
}

void debug(Object? message, {Object? description}) {
  developer.log(jsonEncode(message), name: 'DEBUG', error: description);
}

void info(Object? message, {Object? description}) {
  developer.log(jsonEncode(message), name: 'INFO', error: description);
}

void warn(Object? message, {Object? description}) {
  developer.log(jsonEncode(message), name: 'WARN', error: description);
}

void error(Object? message, {Object? description}) {
  developer.log(jsonEncode(message), name: 'ERROR', error: description);
}

void fatal(Object? message, {Object? description}) {
  developer.log(jsonEncode(message), name: 'FATAL', error: description);
}
