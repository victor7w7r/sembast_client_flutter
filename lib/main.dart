import 'package:bitsdojo_window/bitsdojo_window.dart' show doWhenWindowReady, appWindow;
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;
import 'package:functional_widget_annotation/functional_widget_annotation.dart' show swidget;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/utils/platforms.dart';
import 'package:sembast_client_flutter/views/layout.dart';

part 'generated/main.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(isDesktop) await Window.initialize();
  //setup();
  //await container.resolve<AppConfig>().init();

  runApp(const ProviderScope(
    child: InheritedConsumer(
      child: SembastClientApp()
    )
  ));

  if(isDesktop) {
    doWhenWindowReady(() => appWindow
      ..minSize = const Size(640, 360)
      ..size = const Size(1280, 720)
      ..alignment = Alignment.center
      ..title = "Sembast Client for Flutter"
      ..show()
    );
  }
}

@swidget
Widget sembastClientApp(BuildContext context) {

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      splashFactory: InkRipple.splashFactory
    ),
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      splashFactory: InkRipple.splashFactory
    ),
    themeMode: ThemeMode.dark,
    home: const Layout()
  );
}