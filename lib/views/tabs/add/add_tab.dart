import 'package:flutter/material.dart';

import 'package:code_editor/code_editor.dart';
import 'package:niku/namespace.dart' as n;
import 'package:niku/niku.dart' show Niku;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/config/index.dart';
import 'package:sembast_client_flutter/providers/index.dart';
import 'package:sembast_client_flutter/views/tabs/add/add_tab_controller.dart';

class AddTab extends StatelessWidget {

  const AddTab({super.key});

  @override
  Widget build(context) {

    final lang = context.watch(langProvider);
    final ctl = context.watch(addTabController);

    final model = EditorModel(
      files: [
        FileEditor(
          name: "add.json",
          language: "json",
          code: "{\n\n}",
        )
      ],
      styleOptions: EditorModelStyleOptions(
        editButtonName: dict(50, lang),
        fontSize: 14,
        fontFamily: "CascadiaCode"
      )
    );

    return n.Stack([
      n.Text(dict(34, lang))
        ..bold
        ..n.top = 60
        ..n.left = 35
        ..fontSize = 35,
      n.Wrap([
        n.Wrap([
          n.Text(dict(47, lang))
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
          onSubmit: (_, val) => ctl.requestAdd(context, lang, val),
          textEditingController: ctl.editCtl,
        ))
      )
        ..center,
      if(ctl.key != "") n.Text(dict(51, lang))
        ..fontSize = 15
        ..fontStyle = FontStyle.italic
        ..textAlign = TextAlign.right
        ..n.bottom = 15
        ..n.right = 25
    ]);
  }
}