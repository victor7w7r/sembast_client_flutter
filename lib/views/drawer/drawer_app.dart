import 'package:flutter/material.dart';

import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/providers/index.dart';
import 'package:sembast_client_flutter/config/dict.dart';

class DrawerApp extends StatelessWidget {

  const DrawerApp({super.key});

  @override
  Widget build(context) {

    final theme = context.watch(themeProvider);
    final lang = context.watch(langProvider);

    return Drawer(
      child: n.Stack([
        n.Text('Sembast Client for Flutter')
          ..mt = 30
          ..n.topCenter
          ..bold
          ..fontSize = 20,
        n.Wrap([
          n.Row([
            n.Text(dict(0, lang))
              ..fontSize = 18,
            DayNightSwitcher(
              isDarkModeEnabled: theme.isDark,
              onStateChanged: (_) =>
                context.read(themeProvider.notifier).toggle(),
            ),
          ]),
          n.Row([
            n.Text(dict(1, lang))
              ..fontSize = 17,
            Switch(
              value: lang,
              inactiveThumbColor: Colors.purpleAccent,
              inactiveTrackColor: Colors.purple,
              onChanged: (_) =>
                context.read(langProvider.notifier).toggle()
            ),
            n.Text(dict(2, lang))
              ..fontSize = 17,
          ])
        ])
          ..direction = Axis.vertical
          ..crossCenter
          ..n.center,
        n.Image.asset(theme.isDark ? 'assets/brandwhite.png' : 'assets/brand.png')
          ..n.bottomCenter
          ..width = 250
          ..mb = 10
      ])
    );
  }
}