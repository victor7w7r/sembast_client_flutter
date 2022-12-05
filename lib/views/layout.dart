import 'package:flutter/material.dart';

import 'package:feature_discovery/feature_discovery.dart' show FeatureDiscovery;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/config/index.dart';
import 'package:sembast_client_flutter/providers/index.dart';
import 'package:sembast_client_flutter/utils/platforms.dart';
import 'package:sembast_client_flutter/views/drawer/drawer_app.dart';
import 'package:sembast_client_flutter/views/layout_widgets.dart';
import 'package:sembast_client_flutter/widgets/index.dart';

class Layout extends HookWidget {

  const Layout({super.key});

  @override
  Widget build(context) {

    final isDark = context.watch(isDarkProvider);
    final magicant = context.watch(magicantProvider);
    final isStore = context.watch(storeSelProvider);
    final isDb = context.watch(isDbOpenProvider);
    final lang = context.watch(langProvider);

    final index = useState<int>(0);

    useEffect(() {
      context.read(themeProvider.notifier).acrylic();
      if(locator.get<AppConfig>().firstTime) {
        WidgetsBinding.instance.addPostFrameCallback((_) =>
          FeatureDiscovery.discoverFeatures(context, [
              'feature1',
            ]
          )
        );
        locator.get<AppConfig>().prefs.setBool('first', false);
      }
      return null;
    }, []);

    return n.Stack([
      Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor:Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: isMacOS ? nil : null,
          actions: isMacOS ? [Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: Scaffold.of(ctx).openDrawer
            )
          )] : null
        ),
        drawer: isMacOS ? null : const DrawerApp(),
        endDrawer: isMacOS ? const DrawerApp() : null,
        bottomNavigationBar: !isDb || isStore ? FeatureDisc(
          id: 'feature2',
          above: true,
          backgroundColor: Colors.blue,
          title: dict(71, lang),
          description: dict(72, lang),
          icon: Icons.menu,
          child: NavBar(
            index: index.value,
            isDark: context.watch(isDarkProvider),
            onTap: (i){
              magicant.randomize();
              index.value = i;
            },
            items: isStore
              ? dbLoadedIconsTab(isDark, !lang)
              : iconsTab(isDark, !lang)
          )
        ) : null,
        body: BodyBuilder(isStore: isStore, index: index.value)
      ),
      if(isMacOS) const MacosMenubar(),
      const WindowTitleBar()
    ]);
  }
}