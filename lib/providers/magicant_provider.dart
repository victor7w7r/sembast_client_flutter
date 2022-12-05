import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider, ProviderRef;
import 'package:random_color/random_color.dart' show ColorBrightness, RandomColor;

import 'package:sembast_client_flutter/providers/theme_provider.dart';

class Magicant {

  Magicant(this.ref);

  final ProviderRef ref;
  final _randomColor = RandomColor();

  bool _debounce = true;

  void randomize(){
    if(_debounce){
      _debounce = false;
      Future.delayed(const Duration(seconds: 3), () => _debounce = true);
      ref.read(themeProvider).isDark
        ? ref.read(themeProvider.notifier).colorize(_randomColor.randomColor(
            colorBrightness: ColorBrightness.dark
          ))
        : ref.read(themeProvider.notifier).colorize(_randomColor.randomColor(
            colorBrightness: ColorBrightness.light
          ));
    }
  }
}

final magicantProvider = Provider<Magicant>(Magicant.new);