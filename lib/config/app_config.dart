import 'package:flutter_acrylic/flutter_acrylic.dart' show Window;
import 'package:fpdart/fpdart.dart' show Option;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import 'package:sembast_client_flutter/providers/theme_provider.dart';
import 'package:sembast_client_flutter/utils/platforms.dart';

@singleton
class AppConfig {

  late SharedPreferences prefs;
  ThemeApp theme = ThemeApp.dark(true);
  bool isEng = true;

  @FactoryMethod(preResolve: true)
  static Future<AppConfig> init() async {

    final config = AppConfig()
      ..prefs = await SharedPreferences.getInstance();

    Option.fromNullable(config.prefs.getBool('dark')).fold(
      () => config.prefs.setBool('dark', true)
        .then((_) => config.theme = ThemeApp.dark(!isWindows && !isMacOS)),
      (dark) => config.theme = dark
        ? ThemeApp.dark(!isWindows && !isMacOS)
        : ThemeApp.light(!isWindows && !isMacOS)
    );

    Option.fromNullable(config.prefs.getBool('lang')).fold(
      () => config.prefs.setBool('lang', true)
        .then((_) => config.isEng = true),
      (lang) => config.isEng = lang
    );

    await Window.initialize();

    return config;
  }
}