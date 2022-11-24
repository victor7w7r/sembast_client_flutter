import 'package:flutter/material.dart';

import 'package:flutter_acrylic/flutter_acrylic.dart' show Window, WindowEffect;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sembast_client_flutter/config/index.dart';
import 'package:sembast_client_flutter/utils/platforms.dart';

class ThemeApp {

  ThemeApp(this.isDark, this.themeMode, this.winColor, this.winEffect);

  final bool isDark;
  final ThemeMode themeMode;
  final Color winColor;
  final WindowEffect winEffect;

  factory ThemeApp.light(bool isSolid) => ThemeApp(
    false,
    ThemeMode.light,
    isSolid ? Colors.white : const Color(0xAAFFFFFF),
    isSolid ? WindowEffect.solid : WindowEffect.aero
  );

  factory ThemeApp.dark(bool isSolid) => ThemeApp(
    true,
    ThemeMode.dark,
    isSolid ? Colors.black : const Color(0xCC222222),
    isSolid ? WindowEffect.solid : WindowEffect.aero
  );

}

class ThemeNotifier extends Notifier<ThemeApp> {
  @override
  ThemeApp build() => ThemeApp.light(true);

  Future<void> toggle() async {
    state = ThemeApp(!state.isDark,
      !state.isDark
        ? ThemeMode.dark
        : ThemeMode.light,
      !state.isDark
        ? isLinux ? Colors.black : const Color(0xCC222222)
        : isLinux ? Colors.white : const Color(0xAAFFFFFF),
      state.winEffect
    );
    if(isDesktop) {
      Window.setEffect(
        effect: state.winEffect,
        color: state.winColor,
        dark: state.isDark
      );
    }
    await locator.get<AppConfig>().prefs.setBool('dark', state.isDark);
  }

  void initAcrylic() => Window.setEffect(
    effect: state.winEffect,
    color: state.winColor,
    dark: state.isDark
  );
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeApp>(ThemeNotifier.new);
final isDarkProvider = Provider<bool>((ref) => ref.watch(themeProvider).isDark);