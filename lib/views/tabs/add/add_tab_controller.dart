import 'dart:convert' show jsonDecode;

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' show Either, IO;

import 'package:sembast_client_flutter/config/dict.dart';
import 'package:sembast_client_flutter/functions/index.dart';
import 'package:sembast_client_flutter/providers/db_provider.dart';
import 'package:sembast_client_flutter/utils/alerts.dart';

class AddTabController extends ChangeNotifier {

  AddTabController(this.ref);

  final ChangeNotifierProviderRef ref;

  final queryCtl = TextEditingController();
  final editCtl = TextEditingController();

  String json = "{\n}";
  String key = "";

  void changeCtl(String val) => notifyListeners();

  void requestKey(BuildContext context, bool lang) {
    checkKey(queryCtl.text, ref.read(dbProvider.notifier))
    .then((res){
      if(res == "") {
        alert(context, false, "Error", dict(49, lang));
      } else if (res == "NAN") {
        alert(context, false, "Error", dict(41, lang));
      } else {
        key = queryCtl.text;
        notifyListeners();
      }
    });
  }

  void requestAdd(BuildContext context, bool lang, String? val) {
    if(val != null) {
      final trimmed = val.trim();
      if(trimmed.startsWith('{') && trimmed.endsWith('}')) {
        Either.tryCatch(IO(() => trimmed.replaceAll("'", '"'))
          .map((jsonFiltered) => jsonDecode(jsonFiltered)
        ).run, (e, __) => e).fold(
          (_) => alert(context, false, "Error", dict(52, lang)),
          (record) {
            insert(record, key, ref.read(dbProvider.notifier));
            snackBar(context, dict(54, lang));
            key = "";
            editCtl.text = "";
            queryCtl.text = "";
            notifyListeners();
          }
        );
      } else if(trimmed.startsWith('[')) {
        alert(context, false, "Error", dict(53, lang));
      } else {
        alert(context, false, "Error", dict(52, lang));
      }
    }
  }

  void refresh() {
    key = "";
    editCtl.text = "";
    queryCtl.text = "";
  }
}

final addTabController = ChangeNotifierProvider(AddTabController.new);