import 'dart:io' show exit;

import 'package:flutter/services.dart' show LogicalKeyboardKey;
import 'package:flutter/widgets.dart';

import 'package:riverpod_context/riverpod_context.dart';
import 'package:sembast_client_flutter/config/dict.dart';

import 'package:sembast_client_flutter/providers/lang_provider.dart';
import 'package:sembast_client_flutter/providers/theme_provider.dart';

class MacosMenubar extends StatelessWidget {

  const MacosMenubar({super.key});

  @override
  Widget build(context) {

    final lang = context.watch(langProvider);

    return PlatformMenuBar(menus: [
      PlatformMenu(
        label: 'App',
        menus: [
          PlatformMenuItemGroup(
            members: [
              PlatformMenuItem(
                label: dict(73, lang),
                onSelected: context.read(themeProvider.notifier).toggle,
                shortcut: const SingleActivator(LogicalKeyboardKey.keyB,
                  meta: true
                )
              ),
              PlatformMenuItem(
                label: dict(74, lang),
                onSelected: context.read(langProvider.notifier).toggle,
                shortcut: const SingleActivator(LogicalKeyboardKey.keyL,
                  meta: true
                )
              )
            ]
          ),
          PlatformMenuItemGroup(
            members: [
              PlatformMenuItem(
                label: dict(75, lang),
                onSelected: () => exit(0),
                shortcut: const SingleActivator(LogicalKeyboardKey.keyQ,
                  meta: true),
              )
            ]
          )
        ]
      )
    ]);
  }
}
