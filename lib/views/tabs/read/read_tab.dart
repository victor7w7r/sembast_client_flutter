import 'package:flutter/material.dart';

import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:niku/namespace.dart' as n;
import 'package:niku/niku.dart' show Niku;
import 'package:riverpod_context/riverpod_context.dart' show RiverpodContext;

import 'package:sembast_client_flutter/config/index.dart';
import 'package:sembast_client_flutter/providers/index.dart';
import 'package:sembast_client_flutter/utils/context_extensions.dart';
import 'package:sembast_client_flutter/views/tabs/read/read_tab_controller.dart';

class ReadTab extends StatelessWidget {

  const ReadTab({super.key});

  @override
  Widget build(context) {

    final lang = context.read(langProvider);
    final ctl = context.watch(readTabController);

    return n.Stack([
      n.Text(dict(33, lang))
        ..bold
        ..n.top = 60
        ..n.left = 35
        ..fontSize = 35,
      if(ctl.loading) Niku(const CircularProgressIndicator())
        ..center,
      n.Text(dict(44, lang))
        ..fontSize = 15
        ..fontStyle = FontStyle.italic
        ..n.bottom = 15
        ..n.right = 25,
      n.Wrap([
        n.Wrap([
          n.Text(dict(37, lang))
            ..fontSize = 15,
          Niku(TextField(
            controller: ctl.queryCtl,
            onChanged: ctl.changeCtl
          ))
            ..w = 250
        ])
          ..direction = Axis.horizontal
          ..crossAxisAlignment = WrapCrossAlignment.center
          ..spacing = 10,
        n.Wrap([
          ElevatedButton(
            onPressed: ctl.queryCtl.text == ""
              ? null
              : () => ctl.requestQuery(context, lang),
            child: n.Text(dict(38, lang))
          ),
          ElevatedButton(
            onPressed: () => ctl.requestAll(context, lang),
            child: n.Text(dict(39, lang))
          ),
        ])
          ..direction = Axis.horizontal
          ..crossAxisAlignment = WrapCrossAlignment.center
          ..ml = 40
          ..spacing = 10,
        Niku(ElevatedButton(
          onPressed: () => ctl.requestLimit(context, lang),
          child: n.Text(dict(45, lang))
        ))
          ..ml = 20
      ])
        ..direction = Axis.vertical
        ..crossAxisAlignment = WrapCrossAlignment.center
        ..spacing = 10
        ..n.topCenter
        ..mt = 95,
      if(ctl.firstLoad) Niku(JsonView.string(
        ctl.json,
        theme: JsonViewTheme(
          backgroundColor: context.read(isDarkProvider)
            ? Colors.grey[700]!.withOpacity(0.2)
            : Colors.grey[500]!.withOpacity(0.4),
        )
      ))
        ..w = context.mediaQuerySize.width - 100
        ..h = context.mediaQuerySize.height - 400
        ..mt = 150
        ..center
    ]);
  }
}