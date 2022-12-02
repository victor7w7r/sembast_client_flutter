import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_pty/flutter_pty.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xterm/xterm.dart';

class TerminalTabController extends ChangeNotifier {

  final terminal = Terminal();
  final terminalController = TerminalController();

  late final Pty pty;

  void startPty() {
    pty = Pty.start(
      shell(),
      columns: terminal.viewWidth,
      rows: terminal.viewHeight,
    );

    pty.output
      .cast<List<int>>()
      .transform(const Utf8Decoder())
      .listen(terminal.write);

    pty.exitCode.then((code) {
      terminal.write('the process exited with exit code $code');
    });

    terminal.onOutput = (data) {
      pty.write(const Utf8Encoder().convert(data));
    };

    terminal.onResize = (w, h, pw, ph) {
      pty.resize(h, w);
    };
  }

  String shell() {
    if (Platform.isMacOS || Platform.isLinux) {
      return Platform.environment['SHELL'] ?? 'bash';
    }
    if (Platform.isWindows) return 'cmd.exe';
    return 'sh';
  }

}

final terminalTabController =
  ChangeNotifierProvider.autoDispose((_) => TerminalTabController());