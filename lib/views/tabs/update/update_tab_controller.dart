import 'dart:convert' show jsonDecode;

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' show Either, IO;

import 'package:sembast_client_flutter/config/dict.dart';
import 'package:sembast_client_flutter/functions/index.dart';
import 'package:sembast_client_flutter/providers/db_provider.dart';
import 'package:sembast_client_flutter/utils/index.dart';

class UpdateTabController extends ChangeNotifier {

  UpdateTabController(this.ref);

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
        getRec(key, ref.read(dbProvider.notifier), true).then((rjson) {
          json = rjson;
          key = queryCtl.text;
          notifyListeners();
        });
      } else if (res == "NAN") {
        alert(context, false, "Error", dict(41, lang));
      } else {
        alert(context, false, "Error", dict(56, lang));
      }
    });
  }

  void requestEdit(BuildContext context, bool lang, String? val) {
    if(val != null) {
      final trimmed = val.trim();
      if(trimmed.startsWith('{') && trimmed.endsWith('}')) {
        Either.tryCatch(IO(() => trimmed.replaceAll("'", '"'))
          .map((jsonFiltered) => jsonDecode(jsonFiltered)
        ).run, (e, __) => e).fold(
          (_) => alert(context, false, "Error", dict(52, lang)),
          (record) {
            json = val;
            update(record, key, ref.read(dbProvider.notifier));
            snackBar(context, dict(57, lang));
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
    json = "";
    editCtl.text = "";
    queryCtl.text = "";
  }
}

final updateTabController = ChangeNotifierProvider(UpdateTabController.new);