import 'package:logger/logger.dart';

class SchoolMsUtils {
  static Logger getLogger(String className) {
    final logger = Logger(printer: SimpleLogPrinter(className));
    return logger;
  }
}

class SimpleLogPrinter extends LogPrinter {
  final String className;
  SimpleLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.levelColors[event.level];
    var emoji = PrettyPrinter.levelEmojis[event.level];
    // ignore: avoid_print
    print("$color $emoji $className - ${event.message}");
    return [];
  }
}
