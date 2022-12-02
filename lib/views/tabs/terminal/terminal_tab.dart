import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:niku/namespace.dart' as n;
import 'package:niku/niku.dart' show Niku;
import 'package:riverpod_context/riverpod_context.dart';
import 'package:sembast_client_flutter/providers/index.dart';
import 'package:xterm/xterm.dart';

import 'package:sembast_client_flutter/utils/context_extensions.dart';
import 'package:sembast_client_flutter/views/tabs/terminal/terminal_tab_controller.dart';

class TerminalTab extends HookWidget {

  const TerminalTab({super.key});

  @override
  Widget build(context) {

    final ctl = context.watch(terminalTabController);
    final dark = context.watch(isDarkProvider);

    useEffect((){
      WidgetsBinding.instance.endOfFrame.then((_) => ctl.startPty());
      return null;
    },[]);

    return n.Stack([
      n.Text("Terminal")
        ..bold
        ..n.top = 60
        ..n.left = 35
        ..fontSize = 35,
      Niku(TerminalView(
        ctl.terminal,
        controller: ctl.terminalController,
        theme: TerminalThemes.whiteOnBlack,
        autofocus: true,
        backgroundOpacity: dark ? 0.2 : 0.7,
      ))
        ..w = context.mediaQuerySize.width - 100
        ..h = context.mediaQuerySize.height - 300
        ..mt = 50
        ..center
    ]);
  }
}