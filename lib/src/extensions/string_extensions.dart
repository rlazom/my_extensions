import 'dart:convert' show base64, utf8, json, base64Decode;
import 'dart:developer' show log;
import 'dart:ui' show Color;
import 'package:path/path.dart' as path;

extension StringX on String {
  Color hexToColor() =>
      Color(int.parse(this.substring(1, 7), radix: 16) + 0xFF000000);

  int toInt() => int.parse(this);

  Uri toUri() => Uri.parse(this);

  String toShortString() {
    return this.split('.').last.toLowerCase();
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  DateTime fromTimeStamp({bool inMilliseconds = false}) {
    return DateTime.fromMillisecondsSinceEpoch(toInt() * (inMilliseconds ? 1 : 1000), isUtc: true);
  }

  DateTime get fromIso8601 {
    return DateTime.parse(this);
  }

  String get normalize {
    String decodedUrl = Uri.decodeFull(this);
    return path.normalize(decodedUrl);
    // return path.normalize(this);
  }

  String get encodeToBase64 {
    return base64.encode(utf8.encode(this));
  }

  String? get decodeFromBase64 {
    String? decodedUserName;
    try {
      final List<int> bytes = base64.decode(this);
      decodedUserName = utf8.decode(bytes);
    } catch (e) {
      log('decodeFromBase64() - ERROR this: "$this", e: "$e"');
    }
    return decodedUserName;
  }

  Map<String, dynamic> get parseToMap {
    String jsonString = this.replaceAllMapped(
      RegExp(r'(\w+):'), (match) => '"${match.group(1)}":',
    );

    jsonString = jsonString.replaceAllMapped(
      RegExp(r':\s*([^",{}\[\]\s]+)(?=[,\}])'),
          (match) {
        String value = match.group(1)!;

        // Check bool or null
        if (value == 'true' || value == 'false' || value == 'null') {
          return ': $value';
        }

        // Check int as ID
        int? intValue = int.tryParse(value);
        if (intValue != null && value.length > 5) {
          return ': "$value"';
        }

        // Check numbers
        if(num.tryParse(value) != null){
          return ': $value';
        }

        return ': "$value"';
      },
    );

    try {
      return json.decode(jsonString);
    } catch (e) {
      return {};
    }
  }

  bool get isBase64 {
    if (isEmpty) return false;

    /// First check with regex to discard invalid formats
    final base64Regex = RegExp(
        r'^[a-zA-Z0-9+/]+={0,2}$'
    );

    if (!base64Regex.hasMatch(this) || length % 4 != 0) {
      return false;
    }

    /// Then try to decode to confirm
    try {
      base64Decode(this);
      return true;
    } catch (e) {
      return false;
    }
  }
}

extension StringNullX on String? {
  String? get urlFileName {
    return this?.split('?').first.split('/').last.trim();
  }
}