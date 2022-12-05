import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:niku/namespace.dart' as n;
import 'package:niku/niku.dart' show Niku;
import 'package:riverpod_context/riverpod_context.dart';
import 'package:sembast_client_flutter/config/dict.dart';
import 'package:sembast_client_flutter/providers/index.dart';
import 'package:sembast_client_flutter/widgets/drag_drop.dart';
import 'package:xterm/xterm.dart';

import 'package:sembast_client_flutter/utils/context_extensions.dart';
import 'package:sembast_client_flutter/views/tabs/terminal/terminal_tab_controller.dart';

class TerminalTab extends HookWidget {

  const TerminalTab({super.key});

  @override
  Widget build(context) {

    final lang = context.watch(langProvider);
    final theme = context.watch(themeProvider);

    final ctl = context.watch(terminalTabController);

    useEffect((){
      WidgetsBinding.instance.endOfFrame.then((_) => ctl.init());
      return null;
    },[]);

    return n.Stack([
      n.Text("Terminal")
        ..bold
        ..n.top = 60
        ..n.left = 35
        ..fontSize = 35,
      if(ctl.error) n.Text(dict(67, lang))
        ..n.center
        ..textAlign = TextAlign.center
        ..fontSize = 20,
      if(!ctl.loading && ctl.path == "" && !ctl.error) Niku(FloatingActionButton(
        onPressed: () => ctl.buttonRequest(context, lang),
        backgroundColor: theme.winColor,
        foregroundColor: theme.isDark ? Colors.white : Colors.black,
        child: const Icon(Icons.upload),
      ))
        ..right = 25
        ..bottom = 25,
      if(ctl.loading) n.Column([
        const CircularProgressIndicator(),
        const SizedBox(height: 20),
        n.Text(dict(66, lang)) ..fontSize = 20
      ])
        ..n.center
        ..mainAxisAlignment = MainAxisAlignment.center,
      if(!ctl.loading && ctl.path == "" && !ctl.error) Niku(DragDrop(
          lang: lang,
          dark: theme.isDark,
          drag: (t) => ctl.dragRequest(context, lang, t.files)
        ))
          ..center,
      if(!ctl.loading && ctl.path != "" && !ctl.error) Niku(TerminalView(
        ctl.terminal,
        controller: ctl.terminalController,
        theme: TerminalThemes.whiteOnBlack,
        autofocus: true,
        backgroundOpacity: theme.isDark ? 0.2 : 0.7,
      ))
          ..w = context.mediaQuerySize.width - 100
          ..h = context.mediaQuerySize.height - 300
          ..mt = 50
          ..center
    ]);
  }
}