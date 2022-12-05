import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sembast_client_flutter/config/dict.dart';
import 'package:sembast_client_flutter/functions/index.dart';
import 'package:sembast_client_flutter/providers/db_provider.dart';
import 'package:sembast_client_flutter/utils/alerts.dart';

class DeleteTabController extends ChangeNotifier {

  DeleteTabController(this.ref);

  final ChangeNotifierProviderRef ref;

  final queryCtl = TextEditingController();

  void changeCtl(String val) => notifyListeners();

  void requestAll(BuildContext context, bool lang) =>
    getAll(ref.read(dbProvider.notifier))
      .then((json){
      if(json == "") {
        alert(context, false, "Ups", dict(43, lang));
      } else {
        yesNoAlert(context, dict(63, lang), dict(64, lang), false, dict(19, lang), "No", (){
          deleteAll(ref.read(dbProvider.notifier));
          snackBar(context, dict(65, lang));
          refresh();
          notifyListeners();
        }, (){});
      }
    });

  void requestQuery(BuildContext context, bool lang) =>
    getRec(queryCtl.text, ref.read(dbProvider.notifier), false)
    .then((json){
      if(json == "") {
        alert(context, false, "Ups", dict(40, lang));
      } else if (json == "mismatch") {
        alert(context, false, "Error", dict(41, lang));
      } else {
        yesNoAlert(context, dict(60, lang), dict(61, lang), false, dict(19, lang), "No", (){
          delete(jsonDecode(json), queryCtl.text, ref.read(dbProvider.notifier));
          snackBar(context, dict(62, lang));
          notifyListeners();
        }, (){});
      }
    });

  void refresh() {
    queryCtl.text = "";
    notifyListeners();
  }

}

final deleteTabController = ChangeNotifierProvider(DeleteTabController.new);