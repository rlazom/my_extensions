import 'package:flutter/material.dart' show BuildContext, Theme, ThemeData, Size, Orientation, MediaQuery, Locale;

abstract class BaseLocalizations {
  String translate(String key, {String param, String? defaultValue});
  Locale get locale;
}

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  Size get sizeOf {
    return MediaQuery.sizeOf(this);
  }

  Orientation get orientationOf {
    return MediaQuery.orientationOf(this);
  }

  bool get isLandscape {
    return MediaQuery.orientationOf(this) == Orientation.landscape;
  }

  bool get isMobile {
    final screenWidth = MediaQuery.sizeOf(this).width;
    return screenWidth < 600;
  }
  bool get isTablet {
    final screenWidth = MediaQuery.sizeOf(this).width;
    return screenWidth >= 600;
  }
  bool get isDesktop {
    final screenWidth = MediaQuery.sizeOf(this).width;
    return screenWidth >= 1024;
  }

  // String translate(String key, {String param = ''}) {
  //   return AppLocalizations.of(this)!.translate(key, param: param);
  // }

  /// Métodos de localización
  static BaseLocalizations? _localizations;

  static void configure(BaseLocalizations localizations) {
    _localizations = localizations;
  }

  String translate(String key, {String param = '', String? defaultValue}) {
    assert(_localizations != null,
    'BuildContextX not configured. Call BuildContextX.configure() in your app initialization.');
    return _localizations!.translate(key, param: param, defaultValue: defaultValue);
  }

  String get localeLanguageCode {
    assert(_localizations != null,
    'BuildContextX not configured. Call BuildContextX.configure() in your app initialization.');
    return _localizations!.locale.languageCode;
  }
}