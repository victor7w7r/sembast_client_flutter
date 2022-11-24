import 'package:flutter/material.dart';

import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/platforms.dart';

class ThemeApp {

  ThemeApp(this.isDark, this.themeMode, this.winColor, this.winEffect);

  final bool isDark;
  final ThemeMode themeMode;
  final Color winColor;
  final WindowEffect winEffect;
}

class ThemeNotifier extends Notifier<ThemeApp> {
  @override
  ThemeApp build() => ThemeApp(true, ThemeMode.dark, const Color(0xCC222222), WindowEffect.aero);

  void toggle() {
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
    // await locator.get<AppConfig>().prefs.setBool('dark', state.darkMode);
  }

  //TODO AERO para windows y macos, para solid para linux
  void initAcrylic() => Window.setEffect(
    effect: state.winEffect,
    color: state.winColor,
    dark: state.isDark
  );
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeApp>(ThemeNotifier.new);
final isDarkProvider = Provider<bool>((ref) => ref.watch(themeProvider).isDark);