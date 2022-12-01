import 'dart:convert' show jsonEncode;

import 'package:sembast/sembast.dart';

import 'package:sembast_client_flutter/providers/db_provider.dart';
import 'package:sembast_client_flutter/utils/number.dart';

Future<String> getRec(String key, DbNotifier dbNot) async {

  if(dbNot.isIntKeys) {
    if(isNumeric(key)) {
      final recOp = await dbNot.storeRefInt!.record(int.parse(key)).get(dbNot.db!);
      if(recOp == null) {
        return "";
      } else {
        return jsonEncode(recOp);
      }
    } else {
      return "mismatch";
    }
  } else {
    final recOp = await dbNot.storeRefStr!.record(key).get(dbNot.db!);
    if(recOp == null) {
      return "";
    } else {
      return jsonEncode(recOp);
    }
  }
}