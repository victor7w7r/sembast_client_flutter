import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' show basename;
import 'package:sembast/sembast.dart' show Database, StoreRef;

class DbNotifier extends ChangeNotifier {

  Database? db;
  bool storeSelected = false;
  bool isIntKeys = false;
  StoreRef<int, Map<String, Object?>>? storeRefInt;
  StoreRef<String, Map<String, Object?>>? storeRefStr;
  String dbPath = "";
  String dbName = "";
  String storeName = "";

  void openDb(Database incDb, String dbName) {
    db = incDb;
    dbPath = dbName;
    this.dbName = basename(dbName);
    notifyListeners();
  }

  Future<void> closeDb() async {
    await db!.close();
    storeSelected = false;
    isIntKeys = false;
    storeRefInt = null;
    storeRefStr = null;
    db = null;
    dbName = "";
    dbPath = "";
    storeName = "";
    notifyListeners();
  }

  void attachStore(String storeName,{
    StoreRef<int, Map<String, Object?>>? storeInt,
    StoreRef<String, Map<String, Object?>>? storeStr
  }) {
    if(storeInt != null) {
      storeRefInt = storeInt;
      isIntKeys = true;
    } else if(storeStr != null) {
      storeRefStr = storeStr;
      isIntKeys = false;
    }
    this.storeName = storeName;
    storeSelected = true;
    notifyListeners();
  }

  void detachStore() {
    storeSelected = false;
    isIntKeys = false;
    storeRefInt = null;
    storeRefStr = null;
    storeName = "";
    notifyListeners();
  }

}

final dbProvider = ChangeNotifierProvider<DbNotifier>((_) => DbNotifier());

final storeSelProvider = Provider((ref) =>
  ref.watch(dbProvider).storeSelected
);

final isDbOpenProvider = Provider((ref) =>
  ref.watch(dbProvider).db != null
);