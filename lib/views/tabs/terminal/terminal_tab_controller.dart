import 'dart:convert';
import 'dart:io';

import 'package:cross_file/cross_file.dart' show XFile;
import 'package:dio/dio.dart' show CancelToken;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pty/flutter_pty.dart' show Pty;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' show Task;
import 'package:path/path.dart';
import 'package:xterm/xterm.dart';

import 'package:sembast_client_flutter/config/index.dart';
import 'package:sembast_client_flutter/providers/index.dart';
import 'package:sembast_client_flutter/utils/download.dart';
import 'package:sembast_client_flutter/utils/index.dart';

class TerminalTabController extends ChangeNotifier {

  TerminalTabController(this.ref);

  final terminal = Terminal();
  final terminalController = TerminalController();
  final AutoDisposeChangeNotifierProviderRef ref;

  final _app = locator.get<AppConfig>();
  final _url = "https://github.com/victor7w7r/sembast_client_dart/releases/download/0.0.1";

  bool loading = true;
  bool error = false;
  String path = "";
  bool _disposed = false;

  final _cancel = CancelToken();

  late final Pty pty;

  void init() {

    final location = '${_app.tempPath}/${_app.cliApp}';
    if(!File(location).existsSync()) {
      download('$_url/${_app.cliApp}', location, _cancel).then((res) {
        if(res) {
          if(isLinux || isMacOS) {
            Process.run("bash", ["-c", "chmod +x $location"]).then((_){
              loading = false;
              notifyListeners();
            });
          } else {
            loading = false;
            notifyListeners();
          }
        } else {
          error = true;
          notifyListeners();
        }
      });
    } else {
      loading = false;
      notifyListeners();
    }
  }

  void dragRequest(BuildContext context, bool lang, List<XFile> reqFiles) {
    if(reqFiles.length > 1) {
      alert(context, false, "Error", dict(7, lang));
    } else if (extension(reqFiles.first.path) != ".db") {
      alert(context, false, "Error", dict(8, lang));
    } else {
      path = reqFiles.first.path;
      initPty();
      notifyListeners();
    }
  }

  void buttonRequest(BuildContext context, bool lang) =>
    Task(() async => FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['db'],
      allowMultiple: false,
      lockParentWindow: true,
        withData: true,
      ))
      .map((res) => res?.files.single.path)
      .run()
      .then((path) {
        if(path != null) {
          this.path = path;
          initPty();
          notifyListeners();
        }
      });

  void initPty() {
    pty = Pty.start(
      Platform.isMacOS || Platform.isLinux
        ? "${_app.tempPath}/${_app.cliApp} $path"
        : "${_app.tempPath}\\${_app.cliApp} $path",
      columns: terminal.viewWidth,
      rows: terminal.viewHeight,
    );

    pty.output
      .cast<List<int>>()
      .transform(const Utf8Decoder())
      .listen(terminal.write);

    pty.exitCode.then((code) => terminal.write(dict(68, ref.read(langProvider), [code.toString()])));
    terminal.onOutput = (data) => pty.write(const Utf8Encoder().convert(data));
    terminal.onResize = (w, h, _, __) => pty.resize(h, w);
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    if(path != "") pty.kill();
    if(loading) _cancel.cancel();
    super.dispose();
  }

}

final terminalTabController =
  ChangeNotifierProvider.autoDispose(TerminalTabController.new);