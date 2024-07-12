import 'dart:convert';
import 'dart:developer' as developer;

void trace(Object? message, {Object? error}) {
  developer.log(jsonEncode(message), name: 'TRACE', error: error);
}

void debug(Object? message, {Object? error}) {
  developer.log(jsonEncode(message), name: 'DEBUG', error: error);
}

void info(Object? message, {Object? error}) {
  developer.log(jsonEncode(message), name: 'INFO', error: error);
}

void warn(Object? message, {Object? error}) {
  developer.log(jsonEncode(message), name: 'WARN', error: error);
}

void error(Object? message, {Object? error}) {
  developer.log(jsonEncode(message), name: 'ERROR', error: error);
}

void fatal(Object? message, {Object? error}) {
  developer.log(jsonEncode(message), name: 'FATAL', error: error);
}
