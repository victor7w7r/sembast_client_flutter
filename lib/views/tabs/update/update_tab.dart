import 'package:flutter/material.dart';

import 'package:code_editor/code_editor.dart';
import 'package:niku/namespace.dart' as n;
import 'package:niku/niku.dart';
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/config/index.dart';
import 'package:sembast_client_flutter/providers/index.dart';
import 'package:sembast_client_flutter/views/tabs/update/update_tab_controller.dart';

class UpdateTab extends StatelessWidget {

  const UpdateTab({super.key});

  @override
  Widget build(context) {

    final lang = context.watch(langProvider);
    final ctl = context.watch(updateTabController);

    final model = EditorModel(
      files: [
        FileEditor(
          name: "edit.json",
          language: "json",
          code: ctl.json,
        )
      ],
      styleOptions: EditorModelStyleOptions(
        editButtonName: dict(50, lang),
        fontSize: 14,
        fontFamily: "CascadiaCode"
      )
    );

    return n.Stack([
      n.Text(dict(35, lang))
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
            ..w = 100,
          ElevatedButton(
            onPressed: ctl.queryCtl.text == ""
              ? null
              : () => ctl.requestKey(context, lang),
            child: n.Text(dict(48, lang))
          )
        ])
          ..direction = Axis.horizontal
          ..crossAxisAlignment = WrapCrossAlignment.center
          ..spacing = 10,
      ])
        ..direction = Axis.vertical
        ..crossAxisAlignment = WrapCrossAlignment.center
        ..spacing = 10
        ..n.topCenter
        ..mt = 95,
      if(ctl.key != "") Niku(SingleChildScrollView(
        child: CodeEditor(
          edit: true,
          disableNavigationbar: true,
          model: model,
          onSubmit: (_, val) => ctl.requestEdit(context, lang, val),
          textEditingController: ctl.editCtl,
        ))
      )
        ..center
    ]);
  }
}