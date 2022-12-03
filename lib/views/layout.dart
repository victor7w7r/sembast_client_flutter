import 'package:flutter/material.dart';

import 'package:flutter_acrylic/flutter_acrylic.dart' show TitlebarSafeArea;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/providers/index.dart';
import 'package:sembast_client_flutter/views/drawer/drawer_app.dart';
import 'package:sembast_client_flutter/views/layout_widgets.dart';
import 'package:sembast_client_flutter/widgets/index.dart';

class Layout extends HookWidget {

  const Layout({super.key});

  @override
  Widget build(context) {

    final isDark = context.watch(isDarkProvider);
    final isStore = context.watch(storeSelProvider);
    final isDb = context.watch(isDbOpenProvider);
    final lang = context.watch(langProvider);

    final index = useState<int>(0);

    useEffect(() {
      context.read(themeProvider.notifier).initAcrylic();
      return null;
    }, []);

    return TitlebarSafeArea(
      child: n.Stack([
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor:Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.transparent),
          drawer: const DrawerApp(),
          bottomNavigationBar: !isDb || isStore ? NavBar(
            index: index.value,
            isDark: context.watch(isDarkProvider),
            onTap: (i) => index.value = i,
            items: isStore
              ? dbLoadedIconsTab(isDark, !lang)
              : iconsTab(isDark, !lang)
          ) : null,
          body: BodyBuilder(isStore: isStore, index: index.value)
        ),
        const WindowTitleBar()
      ])
    );

  }
}