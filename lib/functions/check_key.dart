import 'package:sembast/sembast.dart';

import 'package:sembast_client_flutter/providers/db_provider.dart';
import 'package:sembast_client_flutter/utils/number.dart';

Future<String> checkKey(String key, DbNotifier db) async {

  if(db.isIntKeys) {
    if(isNumeric(key)) {
      final recOp = await db.storeRefInt!.record(int.parse(key)).get(db.db!);
      if(recOp != null) {
        return "";
      } else {
        return "OK";
      }
    } else {
      return "NAN";
    }
  } else {
    final recOp = await db.storeRefStr!.record(key).get(db.db!);
    if(recOp != null) {
      return "";
    } else {
      return "OK";
    }
  }
}