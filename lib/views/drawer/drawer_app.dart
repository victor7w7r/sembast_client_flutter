import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/providers/lang_provider.dart';
import 'package:sembast_client_flutter/providers/theme_provider.dart';

class DrawerApp extends StatelessWidget {

  const DrawerApp({super.key});

  @override
  Widget build(context) {

    final theme = context.watch(themeProvider);
    final lang = context.watch(langProvider);

    return Drawer(
      child: n.Stack([
        DrawerHeader(
          child: n.Text('Sembast Client for Flutter')
            ..fontSize = 20,
        ),
      /*  n.Image.asset(theme.darkMode? 'assets/brandwhite.png': 'assets/brand.png')
          ..width = 250.0
          ..height = 75.0*/
        n.Row([
          n.Text('Sembast Client for Flutter')
            ..fontSize = 20,
        ])
          ..mainAxisAlignment = MainAxisAlignment.center
          ..n.center
      ])
    );
  }
}