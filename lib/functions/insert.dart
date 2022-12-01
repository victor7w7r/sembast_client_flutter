import 'package:sembast/sembast.dart';

import 'package:sembast_client_flutter/providers/db_provider.dart';

Future<void> insert(Map<String, dynamic> record, String key, DbNotifier db) async  =>
  db.isIntKeys
    ? await db.storeRefInt!.record(int.parse(key)).put(db.db!, record)
    : await db.storeRefStr!.record(key).put(db.db!, record);