import 'dart:async' show Timer;

import 'package:flutter/material.dart' show Color;
import 'package:flutter_acrylic/flutter_acrylic.dart' show Window;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sembast_client_flutter/config/index.dart';
import 'package:sembast_client_flutter/models/theme_app.dart';
import 'package:sembast_client_flutter/utils/platforms.dart';

class ThemeNotifier extends Notifier<ThemeApp> {

  @override
  ThemeApp build() => locator.get<AppConfig>().theme;

  Future<void> toggle() async {
    !state.isDark
      ? state = ThemeApp.dark()
      : state = ThemeApp.light();
    acrylic();
    await locator.get<AppConfig>().prefs.setBool('dark', state.isDark);
  }

  void colorize(Color color) {
    if(isWindows) {
      double linear = 0.1;
      Color interpolatorBack;
      Timer.periodic(const Duration(milliseconds: 30), (t) {
        interpolatorBack = Color.lerp(state.winColor, color, linear)!;
        state = state.copyWith(winColor: interpolatorBack);
        acrylic();
        linear += 0.1;
        if(linear >= 1) t.cancel();
      });
    } else {
      state = state.copyWith(winColor: color);
      acrylic();
    }
  }

  void acrylic() => Window.setEffect(
    effect: state.winEffect,
    color: isLinux
      ? state.winColor
      : state.isDark
        ? state.winColor.withOpacity(0.5)
        : state.winColor.withOpacity(0.7),
    dark: state.isDark
  );
}

final themeProvider =
  NotifierProvider<ThemeNotifier, ThemeApp>(ThemeNotifier.new);

final isDarkProvider = Provider<bool>((ref) =>
  ref.watch(themeProvider).isDark
);