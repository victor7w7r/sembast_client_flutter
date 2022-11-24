import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import 'package:sembast_client_flutter/providers/theme_provider.dart';
import 'package:sembast_client_flutter/utils/platforms.dart';

@singleton
class AppConfig {

  late SharedPreferences prefs;
  late ThemeApp theme;

  @FactoryMethod(preResolve: true)
  static Future<AppConfig> init() async {

    final config = AppConfig();

    config.prefs = await SharedPreferences.getInstance();

    Option.fromNullable(config.prefs.getBool('dark')).fold(
      () => config.prefs.setBool('dark', true)
        .then((_) => config.theme = ThemeApp.dark(!isWindows && !isMacOS)),
      (dark) => config.theme = dark
        ? ThemeApp.dark(!isWindows && !isMacOS)
        : ThemeApp.light(!isWindows && !isMacOS)
    );

    return config;
  }
}