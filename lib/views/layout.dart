import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/providers/index.dart';
import 'package:sembast_client_flutter/views/drawer/drawer_app.dart';
import 'package:sembast_client_flutter/views/layout_widgets.dart';
import 'package:sembast_client_flutter/utils/platforms.dart';
import 'package:sembast_client_flutter/widgets/index.dart';

class Layout extends HookWidget {

  const Layout({super.key});

  @override
  Widget build(context) {

    final isDark = context.watch(isDarkProvider);
    final isStore = context.watch(storeSelProvider);
    final lang = context.watch(langProvider);

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
        bottomNavigationBar: NavBar(
          index: index.value,
          isDark: context.watch(isDarkProvider),
          onTap: (i) => index.value = i,
          items: isStore
            ? dbLoadedIconsTab(isDark, !lang)
            : iconsTab(isDark, !lang)
        ),
        body: BodyBuilder(isStore: isStore, index: index.value)
      ),
      const WindowTitleBar()
    ]);

  }
}