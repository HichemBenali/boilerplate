import '../config/app.dart';
import 'package:logger/logger.dart';

class Log {
  static Logger _logger = new Logger();

  static void verbose(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (DEBUG) _logger.d(message, error, stackTrace);
  }

  static void debug(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (DEBUG) _logger.d(message, error, stackTrace);
  }

  static void info(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (DEBUG) _logger.i(message, error, stackTrace);
  }

  static void warning(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (DEBUG) _logger.w(message, error, stackTrace);
  }

  static void error(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (DEBUG) _logger.e(message, error, stackTrace);
  }

  static void wtf(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (DEBUG) _logger.wtf(message, error, stackTrace);
  }

  static void log(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (DEBUG) _logger.log(message, error, stackTrace);
  }
}
