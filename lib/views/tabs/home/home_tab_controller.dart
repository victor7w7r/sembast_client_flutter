import 'dart:io' show File;

import 'package:flutter/material.dart';

import 'package:cross_file/cross_file.dart' show XFile;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' show Task, TaskEither;
import 'package:path/path.dart' show extension;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'package:sembast_client_flutter/config/dict.dart';
import 'package:sembast_client_flutter/functions/check.dart';
import 'package:sembast_client_flutter/providers/db_provider.dart';
import 'package:sembast_client_flutter/utils/index.dart';
import 'package:sembast_client_flutter/views/tabs/add/add_tab_controller.dart';
import 'package:sembast_client_flutter/views/tabs/delete/delete_tab_controller.dart';
import 'package:sembast_client_flutter/views/tabs/read/read_tab_controller.dart';
import 'package:sembast_client_flutter/views/tabs/update/update_tab_controller.dart';

class HomeTabController extends ChangeNotifier {

  HomeTabController(this.ref);

  final ChangeNotifierProviderRef ref;
  final storectl = TextEditingController();

  final _passctl = TextEditingController();

  void dragRequest(BuildContext context, bool lang, List<XFile> reqFiles) {
    if(reqFiles.length > 1) {
      alert(context, false, "Error", dict(7, lang));
    } else if (extension(reqFiles.first.path) != ".db") {
      alert(context, false, "Error", dict(8, lang));
    } else {
      request(context, lang, reqFiles.first.path);
    }
  }

  void buttonRequest(BuildContext context, bool lang, bool isDb) => isDb
    ? yesNoAlert(
        context,
        dict(20, lang),
        dict(21, lang),
        false,
        dict(19, lang),
        "No",
        () {
          ref.read(dbProvider.notifier).closeDb();
          refresh();
        },
        (){})
    : Task(() async => FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db'],
        allowMultiple: false,
        lockParentWindow: true,
          withData: true,
        ))
      .map((res) => res?.files.single.path)
      .run()
      .then((path) => path != null ? request(context, lang, path) : {});

  void request(BuildContext context, bool lang, String? path) {

    late final SembastCodec codec;
    final lines = File(path!).readAsLinesSync();

    if(lines.isEmpty) {
      alert(context, false, "Error", dict(9, lang));
      return;
    }
    if(!lines.first.contains(',"sembast":')) {
      alert(context, false, "Error", dict(10, lang));
      return;
    }
    if(lines.first.contains(',"codec":')) {
      input(context, dict(11, lang), dict(12, lang), true, false, "pass", _passctl, (val) {
        if(val != "") {
          _passctl.text = "";
          codec = sembastCodec(password: val);
          TaskEither.tryCatch(
            () async => databaseFactoryIo.openDatabase(path, codec: codec),
            (e, _) {
              alert(context, false, "Error", dict(13, lang));
              return null;
            }
          )
          .run()
          .then((res) => res.fold(
            (_) {},
            (db) => ref.read(dbProvider.notifier).openDb(db, path)
          ));
        }
      });
    } else {
      databaseFactoryIo.openDatabase(path).then((db) =>
        ref.read(dbProvider.notifier).openDb(db, path));
    }
  }

  void storeChange(String val) => notifyListeners();

  void requestCheck(BuildContext context, Database db, bool lang) =>
    check(db, storectl.text).then((res) {
      if (res["keyType"] == "none") {
        alert(context, false, dict(22, lang), dict(23, lang, [storectl.text]));
      } else if (res["keyType"] == "int") {
        alert(context, false, dict(22, lang), dict(24, lang, [storectl.text, res["length"]!]));
      } else {
        alert(context, false, dict(22, lang), dict(25, lang, [storectl.text, res["length"]!]));
      }
  });

  void requestUse(BuildContext context, Database db, bool lang) =>
    check(db, storectl.text).then((res) {
      if (res["keyType"] == "none") {
        yesNoAlert(
          context,
          dict(26, lang),
          dict(27, lang),
          true,
          "int",
          "str",
          () {
            ref.read(dbProvider.notifier)
              .attachStore(storectl.text, storeInt: intMapStoreFactory.store(storectl.text));
            snackBar(context, dict(28, lang, ["0"]));
          }, () {
            ref.read(dbProvider.notifier)
              .attachStore(storectl.text, storeStr: stringMapStoreFactory.store(storectl.text));
            snackBar(context, dict(29, lang, ["0"]));
          }
        );
      } else if (res["keyType"] == "int") {
        ref.read(dbProvider.notifier)
          .attachStore(storectl.text, storeInt: intMapStoreFactory.store(storectl.text));
        snackBar(context, dict(28, lang, [res["length"]!]));
      } else {
        ref.read(dbProvider.notifier)
          .attachStore(storectl.text, storeStr: stringMapStoreFactory.store(storectl.text));
        snackBar(context, dict(29, lang, [res["length"]!]));
      }
    });

  void requestDetach(BuildContext context, bool lang) {
    snackBar(context, dict(32, lang));
    ref.read(dbProvider.notifier).detachStore();
    refresh();
    notifyListeners();
  }

  void refresh() {
    ref.read(addTabController.notifier).refresh();
    ref.read(deleteTabController.notifier).refresh();
    ref.read(readTabController.notifier).refresh();
    ref.read(updateTabController.notifier).refresh();
  }

}

final homeTabController = ChangeNotifierProvider(HomeTabController.new);