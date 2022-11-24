import 'package:flutter/material.dart';

import 'package:flutter_acrylic/flutter_acrylic.dart' show TitlebarSafeArea;
import 'package:curved_navigation_bar/curved_navigation_bar.dart' show CurvedNavigationBar;
import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart';
import 'package:stacked/stacked.dart' show ViewModelBuilder;

import 'package:sembast_client_flutter/providers/theme_provider.dart';
import 'package:sembast_client_flutter/views/layout_view_model.dart';
import 'package:sembast_client_flutter/views/layout_widgets.dart';
import 'package:sembast_client_flutter/utils/platforms.dart';
import 'package:sembast_client_flutter/widgets/title_bar.dart';

class Layout extends StatelessWidget {

  const Layout({super.key});

  @override
  Widget build(context) {

    final isDark = context.watch(isDarkProvider);

    return ViewModelBuilder<LayoutViewModel>.reactive(
      viewModelBuilder: () => LayoutViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (_, model, __) => TitlebarSafeArea(
        child: n.Stack([
          Scaffold(
            backgroundColor: isDesktop ? Colors.transparent : null,
            bottomNavigationBar: CurvedNavigationBar(
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 400),
              backgroundColor: Colors.transparent,
              color: isDark
                ? Colors.grey.withOpacity(0.2)
                : Colors.grey.withOpacity(0.4),
              key: model.key,
              index: model.index,
              height: 60,
              onTap: model.changeIndex,
              items: iconsTab(isDark)
            ),
            body: tabs.elementAt(model.index)
          ),
          const WindowTitleBar()
        ])
      )
    );
  }
}