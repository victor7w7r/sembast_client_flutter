import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart' show appWindow, doWhenWindowReady;
import 'package:flutter_acrylic/flutter_acrylic.dart' show Window;
import 'package:fpdart/fpdart.dart' show Option, Task;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import 'package:sembast_client_flutter/models/theme_app.dart';
import 'package:sembast_client_flutter/utils/platforms.dart';

@singleton
class AppConfig {

  late final SharedPreferences prefs;
  ThemeApp theme = ThemeApp.dark();
  bool isEng = true;
  bool firstTime = false;
  String tempPath = "";
  String cliApp = "";

  @FactoryMethod(preResolve: true)
  static Future<AppConfig> init() async {

    WidgetsFlutterBinding.ensureInitialized();

    final config = AppConfig()
      ..prefs = await SharedPreferences.getInstance()
      ..tempPath = await const Task(getTemporaryDirectory)
        .map((dir) => dir.path)
        .run();

    if(isWindows) {
      config.cliApp = "sembast_cli_win64.exe";
    } else if (isLinux) {
      config.cliApp = "sembast_cli_linux64";
    } else if (isMacOS) {
      config.cliApp = "sembast_cli_macos64";
    }

    Option.fromNullable(config.prefs.getBool('dark')).fold(
      () => config.prefs.setBool('dark', true)
        .then((_) => config.theme = ThemeApp.dark()),
      (dark) => config.theme = dark
        ? ThemeApp.dark()
        : ThemeApp.light()
    );

    Option.fromNullable(config.prefs.getBool('lang')).fold(
      () => config.prefs.setBool('lang', true)
        .then((_) => config.isEng = true),
      (lang) => config.isEng = lang
    );

    Option.fromNullable(config.prefs.getBool('first')).fold(
      () => config.prefs.setBool('first', true)
        .then((_) => config.firstTime = true),
      (_) => config.firstTime = false
    );

    await Window.initialize();

    doWhenWindowReady(() => appWindow
      ..minSize = const Size(640, 360)
      ..size = const Size(1280, 720)
      ..alignment = Alignment.center
      ..title = "Sembast Client for Flutter"
      ..show()
    );

    return config;
  }
}