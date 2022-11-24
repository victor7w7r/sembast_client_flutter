import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/providers/theme_provider.dart';

class HomeTab extends StatelessWidget {

  const HomeTab({super.key});

  @override
  Widget build(context) {

    final isDark = context.watch(isDarkProvider);

    return n.Stack([
      n.IconButton(
        isDark ? Icons.light_mode : Icons.dark_mode,
        color: isDark ? Colors.white : Colors.black,
        onPressed: () => context.read(themeProvider.notifier).toggle(),
      )
        ..n.top = 40
        ..n.right = 10,
    ]);
  }
}