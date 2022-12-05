import 'package:flutter/material.dart';

import 'package:flutter_acrylic/flutter_acrylic.dart' show WindowEffect;

import 'package:sembast_client_flutter/utils/platforms.dart';

class ThemeApp {

  ThemeApp(
    this.isDark,
    this.themeMode,
    this.winColor,
    this.winEffect
  );

  final bool isDark;
  final ThemeMode themeMode;
  final Color winColor;
  final WindowEffect winEffect;

  factory ThemeApp.light() => ThemeApp(
    false,
    ThemeMode.light,
    Colors.white,
    !isWindows ? WindowEffect.solid : WindowEffect.aero
  );

  factory ThemeApp.dark() => ThemeApp(
    true,
    ThemeMode.dark,
    const Color(0xFF212121),
    !isWindows ? WindowEffect.solid : WindowEffect.aero
  );

  ThemeApp copyWith({
    bool? isDark,
    ThemeMode? themeMode,
    ThemeData? themeLightData,
    ThemeData? themeDarkData,
    Color? winColor,
    WindowEffect? winEffect
  }) => ThemeApp(
    isDark ?? this.isDark,
    themeMode ?? this.themeMode,
    winColor ?? this.winColor,
    winEffect ?? this.winEffect
  );

}