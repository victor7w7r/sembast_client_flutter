import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;
import 'package:nester/nester.dart' show Nester;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/config/locator.dart';
import 'package:sembast_client_flutter/providers/theme_provider.dart';
import 'package:sembast_client_flutter/views/layout.dart';

void main() => setup().then((_) => runApp(
  Nester.list([
    (next) => ProviderScope(child: next),
    (next) => InheritedConsumer(child: next),
    (_) => const SembastClientApp(),
  ])
));

class SembastClientApp extends StatelessWidget {

  const SembastClientApp({super.key});

  @override
  Widget build(context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:  ThemeData(
      useMaterial3: true,
      splashFactory: InkRipple.splashFactory
    ),
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      splashFactory: InkRipple.splashFactory
    ),
    themeMode: context.watch(isDarkProvider)
      ? ThemeMode.dark
      : ThemeMode.light,
    home: const Layout()
  );
}