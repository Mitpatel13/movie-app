import 'package:logger/logger.dart';
class AppLog{
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
    ),
  );
  static i(var m){
    _logger.i(m);

  }
  static e(var m){
    _logger.e(m);
  }
  static w(var m){
    _logger.w(m);
  }
  static d(var m){
    _logger.d(m);
  }
  static t(var m){
    _logger.t(m);
  }
  static f(var m){
    _logger.f(m);
  }
  static log(Level level,m){
    _logger.log(level, m);
  }
}