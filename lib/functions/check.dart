import 'package:fpdart/fpdart.dart' show TaskEither;
import 'package:sembast/sembast.dart';

Future<Map<String,String>> check(Database db, String store) async {

  StoreRef<int, Map<String, Object?>> storeRefInt;
  StoreRef<String, Map<String, Object?>> storeRefStr;

  List<Map<String,Object?>> listIntKeys = [];
  List<Map<String,Object?>> listStrKeys = [];

  await TaskEither.tryCatch(() async {
    storeRefInt = intMapStoreFactory.store(store);
    listIntKeys = (await storeRefInt.find(db)).map((sn) => sn.value).toList();
  }, (_, __) {}).run();

  await TaskEither.tryCatch(() async {
    storeRefStr = stringMapStoreFactory.store(store);
    listStrKeys = (await storeRefStr.find(db)).map((sn) => sn.value).toList();
  }, (_, __) {}).run();

  if(listIntKeys.isEmpty && listStrKeys.isEmpty) {
    return { "keyType": "none" };
  } else {
    if(listIntKeys.isNotEmpty) return { "keyType": "int", "length" : listIntKeys.length.toString() };
    if(listStrKeys.isNotEmpty) return { "keyType": "str", "length" : listStrKeys.length.toString() };
  }
  return {};
}