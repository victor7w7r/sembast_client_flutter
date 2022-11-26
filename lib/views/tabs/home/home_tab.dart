import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/providers/theme_provider.dart';
import 'package:sembast_client_flutter/views/tabs/home/home_tab_controller.dart';

class HomeTab extends StatelessWidget {

  const HomeTab({super.key});

  @override
  Widget build(context) {

    final isDark = context.watch(isDarkProvider);
    final ctl = context.watch(homeTabController);

    return n.Stack([
      n.IconButton(
        isDark ? Icons.light_mode : Icons.dark_mode,
        color: isDark ? Colors.white : Colors.black,
        onPressed: () => context.read(themeProvider.notifier).toggle(),
      )
        ..n.top = 40
        ..n.right = 10,
      n.Text(ctl.counter.toString())
        ..n.center,
      n.Button(n.Text('Increment'),
        onPressed: ctl.incrementCounter,
      )
        ..n.bottom = 40
        ..n.center,
    ]);
  }
}