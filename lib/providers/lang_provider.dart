import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sembast_client_flutter/config/index.dart';

class LangNotifier extends Notifier<bool> {

  @override
  bool build() => locator.get<AppConfig>().isEng;

  Future<void> toggle() async {
    state = !state;
    await locator.get<AppConfig>().prefs.setBool('lang', state);
  }

}

final langProvider = NotifierProvider<LangNotifier, bool>(LangNotifier.new);