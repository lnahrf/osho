import 'dart:io';

class OshoLogger {
  bool? debug;
  String? filePath;
  Function? prefix;
  Function? suffix;
  Function(String log)? onLog;

  OshoLogger({this.debug, this.filePath, this.prefix, this.suffix, this.onLog});

  Future<void> log(String message) async {
    String line = message;
    if (prefix != null) line = prefix!() + line;
    if (suffix != null) line = line + suffix!();
    if (debug != null) print(line);
    if (onLog != null) await onLog!(line);
    if (filePath != null) await _writeLogToFile(line);
  }

  Future<void> _writeLogToFile(String log) async {
    File(filePath!).writeAsString('$log \n', mode: FileMode.append);
  }
}
