import 'package:intl/intl.dart' show DateFormat;

extension DateTimeX on DateTime {
  int get toTimeStamp => millisecondsSinceEpoch ~/ 1000;
  // String get toIso8601 => this.toUtc().toIso8601String().replaceAll('-', '');
  String get toIso8601 => DateFormat("yyyyMMdd'T'HHmmss'Z'").format(this.toUtc());
  // String get toStrDate => DateFormat.yMd('es').add_jm().format(this.toUtc());
  // String get toStrDate => DateFormat('yMMMEd', 'es').addPattern('- h:mma').format(this);
  String get toStrDate {
    // return DateFormat('yMMMEd', 'es').addPattern('- h:mma').format(this);
    final isMidnight = hour == 0 && minute == 0;
    final dateFormat = DateFormat('yMMMEd', 'es');

    if (isMidnight) {
      return dateFormat.format(this); // Only date
    } else {
      return dateFormat.addPattern('- h:mma').format(this); // Date + time
    }
  }
}