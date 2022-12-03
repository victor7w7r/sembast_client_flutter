import 'package:flutter/material.dart';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart' show DottedBorder;
import 'package:niku/namespace.dart' as n;
import 'package:nester/nester.dart' show Nester;

import 'package:sembast_client_flutter/config/dict.dart';
import 'package:sembast_client_flutter/utils/context_extensions.dart';

class DragDrop extends StatelessWidget {

  const DragDrop({
    super.key,
    required this.drag,
    required this.lang,
    required this.dark,
  });

  final void Function(DropDoneDetails details) drag;
  final bool lang;
  final bool dark;

  @override
  Widget build(context) => Nester.list([
    (next) => SizedBox(
      width: (context.mediaQuerySize.width / 2) + 170,
      height: context.mediaQuerySize.height / 2.5,
      child: next
    ),
    (next) => DropTarget(
      onDragDone: drag,
      child: next
    ), (next) => DottedBorder(
      color: dark ? Colors.white : Colors.black,
      strokeWidth: 1,
      dashPattern: const [6, 4],
      child: next
    ), (_) => n.Wrap([
      n.Icon(Icons.upload_file)
        ..size = 100
        ..color = dark ? Colors.grey[500] : Colors.grey[600],
      n.Text(dict(4, lang))
        ..fontSize = 20,
      n.Text(dict(5, lang))
        ..textAlign = TextAlign.center
        ..fontSize = 15
    ])
      ..spacing = 10
      ..direction = Axis.vertical
      ..center
      ..n.center
  ]);
}