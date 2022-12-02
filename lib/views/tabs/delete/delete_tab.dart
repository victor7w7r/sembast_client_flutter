import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;
import 'package:niku/niku.dart';
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/config/index.dart';
import 'package:sembast_client_flutter/providers/index.dart';
import 'package:sembast_client_flutter/views/tabs/delete/delete_tab_controller.dart';

class DeleteTab extends StatelessWidget {

  const DeleteTab({super.key});

  @override
  Widget build(context) {

    final lang = context.watch(langProvider);
    final ctl = context.watch(deleteTabController);

    return n.Stack([
      n.Text(dict(36, lang))
        ..bold
        ..n.top = 60
        ..n.left = 35
        ..fontSize = 35,
      n.Wrap([
        n.Wrap([
          n.Text(dict(55, lang))
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
            child: n.Text(dict(58, lang))
          ),
          ElevatedButton(
            onPressed: () => ctl.requestAll(context, lang),
            child: n.Text(dict(59, lang))
          ),
        ])
          ..direction = Axis.horizontal
          ..crossAxisAlignment = WrapCrossAlignment.center
          ..ml = 100
          ..spacing = 10,
      ])
        ..direction = Axis.vertical
        ..crossAxisAlignment = WrapCrossAlignment.center
        ..spacing = 10
        ..n.center
        ..mt = 95,
    ]);
  }
}