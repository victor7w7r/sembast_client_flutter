import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;
import 'package:niku/niku.dart' show Niku;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/config/index.dart';
import 'package:sembast_client_flutter/providers/index.dart';
import 'package:sembast_client_flutter/views/tabs/home/home_tab_controller.dart';
import 'package:sembast_client_flutter/views/tabs/home/home_tab_widgets.dart';
import 'package:sembast_client_flutter/widgets/index.dart';

class HomeTab extends StatelessWidget {

  const HomeTab({super.key});

  @override
  Widget build(context) {

    final db = context.watch(dbProvider);
    final lang = context.watch(langProvider);
    final dark = context.watch(isDarkProvider);

    final ctl = context.watch(homeTabController);

    return n.Stack([
      n.Text(dict(3, lang))
        ..bold
        ..n.top = 60
        ..n.left = 35
        ..fontSize = 35,
      Niku(FloatingActionButton(
        onPressed: () => ctl.buttonRequest(context, lang, db.db != null),
        backgroundColor: Colors.blue,
        child: Icon(db.db == null ? Icons.upload : Icons.close),
      ))
        ..right = 25
        ..bottom = 25,
      db.db == null ? (
        Niku(DragDrop(
          lang: lang,
          dark: dark,
          drag: (t) => ctl.dragRequest(context, lang, t.files)
        ))
          ..center
      ) : Niku(DataLoaded(
        lang: lang,
        dark: dark,
        dbName: db.dbName,
        storeName: db.storeName,
        ctl: ctl.storectl,
        change: ctl.storeChange,
        check: () => ctl.requestCheck(context, db.db!, lang),
        use: () => ctl.requestUse(context, db.db!, lang),
        detach: () => ctl.requestDetach(context, lang)
      ))
        ..center
    ]);
  }
}