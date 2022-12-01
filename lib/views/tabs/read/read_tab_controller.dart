import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sembast_client_flutter/config/dict.dart';
import 'package:sembast_client_flutter/functions/index.dart';
import 'package:sembast_client_flutter/providers/db_provider.dart';
import 'package:sembast_client_flutter/utils/alerts.dart';

class ReadTabController extends ChangeNotifier {

  ReadTabController(this.ref);

  final ChangeNotifierProviderRef ref;

  final queryCtl = TextEditingController();
  final limitCtl = TextEditingController();
  bool firstLoad = false;
  bool loading = false;
  String json = "{}";

  void changeCtl(String val) => notifyListeners();

  void requestAll(BuildContext context, bool lang) {
    loading = true;
      getAll(ref.read(dbProvider.notifier))
      .then((json){
      if(json == "") {
        alert(context, false, "Ups", dict(43, lang));
        loading = false;
      } else {
        this.json = json;
        firstLoad = true;
        snackBar(context, dict(42, lang));
        loading = false;
        notifyListeners();
      }
    });

  }

  void requestQuery(BuildContext context, bool lang) =>
    getRec(queryCtl.text, ref.read(dbProvider.notifier))
    .then((json){
      if(json == "") {
        alert(context, false, "Ups", dict(40, lang));
      } else if (json == "mismatch") {
        alert(context, false, "Error", dict(41, lang));
      } else {
        this.json = json;
        firstLoad = true;
        snackBar(context, dict(42, lang));
        notifyListeners();
      }
    });

  void requestLimit(BuildContext context, bool lang) =>
    getAll(ref.read(dbProvider.notifier))
    .then((json) => json == ""
      ? alert(context, false, "Ups", dict(43, lang))
      : input(context, dict(46, lang), dict(12, lang), false, false, "25", limitCtl, (val) {
        if(val != "") {
          limit(int.parse(val), ref.read(dbProvider.notifier))
          .then((json){
            if(json == "") {
              alert(context, false, "Ups", dict(43, lang));
            } else {
              this.json = json;
              firstLoad = true;
              snackBar(context, dict(42, lang));
              notifyListeners();
            }
          });
        }
      })
    );
}

final readTabController = ChangeNotifierProvider(ReadTabController.new);