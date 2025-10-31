import 'package:my_extensions/src/extensions/num_extensions.dart';

extension DurationX on Duration {
  String toTimeFormattedString() {
    String twoDigitSeconds = inSeconds.remainder(60).toStringAndFill();
    String twoDigitMinutes = '${inMinutes.remainder(60).toStringAndFill()}:';
    String twoDigitHours = inHours == 0 ? '' : '${inHours.toStringAndFill()}:';

    String finalStr = '$twoDigitHours$twoDigitMinutes$twoDigitSeconds';
    return finalStr;
  }
}