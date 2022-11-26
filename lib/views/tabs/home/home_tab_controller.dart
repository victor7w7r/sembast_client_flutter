import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabController extends ChangeNotifier {

  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();
  }

}

final homeTabController = ChangeNotifierProvider((_) => HomeTabController());