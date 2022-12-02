import 'package:sembast/sembast.dart';

import 'package:sembast_client_flutter/providers/db_provider.dart';

Future<void> delete(Map<String, dynamic> record, String key, DbNotifier db) async  =>
  db.isIntKeys
    ? await db.storeRefInt!.record(int.parse(key)).delete(db.db!)
    : await db.storeRefStr!.record(key).delete(db.db!);

Future<void> deleteAll(DbNotifier db) async  =>
  db.isIntKeys
    ? await db.storeRefInt!.delete(db.db!)
    : await db.storeRefStr!.delete(db.db!);