import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' show WindowEffect;

import 'package:sembast_client_flutter/utils/platforms.dart';

part 'theme_app.freezed.dart';

@freezed
class ThemeApp with _$ThemeApp {

  const factory ThemeApp(
    bool isDark,
    ThemeMode themeMode,
    Color winColor,
    WindowEffect winEffect
  ) = _ThemeApp;

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
}