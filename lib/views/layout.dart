import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart' show CurvedNavigationBar;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/views/drawer/drawer_app.dart';
import 'package:sembast_client_flutter/providers/theme_provider.dart';
import 'package:sembast_client_flutter/views/layout_widgets.dart';
import 'package:sembast_client_flutter/utils/platforms.dart';
import 'package:sembast_client_flutter/widgets/title_bar.dart';

class Layout extends HookWidget {

  const Layout({super.key});

  @override
  Widget build(context) {

    final isDark = context.watch(isDarkProvider);

    final index = useState<int>(0);

    useEffect(() {
      context.read(themeProvider.notifier).initAcrylic();
      return null;
    }, []);

    return n.Stack([
      Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: isDesktop ? Colors.transparent : null,
        appBar: AppBar(backgroundColor: Colors.transparent),
        drawer: const DrawerApp(),
        bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 400),
          backgroundColor: Colors.transparent,
          color: isDark
            ? Colors.grey.withOpacity(0.2)
            : Colors.grey.withOpacity(0.4),
          index: index.value,
          height: 60,
          onTap: (i) => index.value = i,
          items: iconsTab(isDark)
        ),
        body: tabs.elementAt(index.value)
      ),
      const WindowTitleBar()
    ]);

  }
}