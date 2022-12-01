import 'dart:convert' show jsonEncode;

import 'package:fpdart/fpdart.dart';
import 'package:sembast/sembast.dart';

import 'package:sembast_client_flutter/providers/db_provider.dart';

Future<String> getAll(DbNotifier dbNot) async {

  List<Map<String,Object?>> listIntKeys = [];
  List<Map<String,Object?>> listStrKeys = [];

  dbNot.isIntKeys
    ? listIntKeys = await Task(() => dbNot.storeRefInt!.find(dbNot.db!))
        .map((lsn) => IO(lsn.map((sn) => sn.value).toList)
          .map((ls) => Either.tryCatch(
              () => ls.sublist(0, 25),
              (e, _) => e
            ).getOrElse((_) => ls))
          .run()
        ).run()
    : listStrKeys = await Task(() => dbNot.storeRefStr!.find(dbNot.db!))
      .map((lsn) => IO(lsn.map((sn) => sn.value).toList)
        .map((ls) => Either.tryCatch(
            () => ls.sublist(0, 25),
            (e, _) => e
          ).getOrElse((_) => ls))
        .run()
      ).run();

  if(listIntKeys.isEmpty && listStrKeys.isEmpty) {
    return "";
  }

  if(dbNot.isIntKeys && listIntKeys.isNotEmpty) {
    return jsonEncode(listIntKeys);
  } else {
    return jsonEncode(listStrKeys);
  }

}