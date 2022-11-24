import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/providers/theme_provider.dart';
import 'package:sembast_client_flutter/utils/platforms.dart';

class LayoutViewModel extends ChangeNotifier {

  int index = 0;

  final key = GlobalKey<CurvedNavigationBarState>();

  void init(BuildContext context) {
    if(isDesktop) context.read(themeProvider.notifier).initAcrylic();
  }

  void changeIndex(int i) {
    index = i;
    notifyListeners();
  }

}