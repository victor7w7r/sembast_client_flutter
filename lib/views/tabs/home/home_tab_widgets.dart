import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;
import 'package:niku/niku.dart' show Niku;

import 'package:sembast_client_flutter/config/dict.dart';

class DataLoaded extends StatelessWidget {

  const DataLoaded({
    super.key,
    required this.lang,
    required this.dark,
    required this.ctl,
    required this.dbName,
    required this.storeName,
    required this.change,
    required this.check,
    required this.use,
    required this.detach
  });

  final bool lang;
  final bool dark;
  final TextEditingController ctl;
  final String dbName;
  final String storeName;
  final void Function(String)? change;
  final VoidCallback check;
  final VoidCallback use;
  final VoidCallback detach;

  @override
  Widget build(context) => n.Wrap([
    n.Icon(Icons.dataset)
      ..size = 100
      ..color = dark ? Colors.grey[500] : Colors.grey[600],
    n.Text(dict(14, lang, [dbName]))
      ..fontSize = 20,
    n.Text(dict(15, lang))
      ..fontSize = 18,
    Niku(TextField(
      controller: ctl,
      onChanged: change,
      decoration: const InputDecoration(hintText: "store"),
    ))
      ..w = 250,
    n.Wrap([
      ElevatedButton(
        onPressed: ctl.text == "" ? null : check,
        child: n.Text(dict(16, lang))
      ),
      ElevatedButton(
        onPressed: ctl.text == "" ? null : use,
        child: n.Text(dict(17, lang))
      )
    ])
      ..spacing = 10
      ..direction = Axis.horizontal,
    n.Text( storeName == "" ? dict(18, lang) : dict(30, lang, [storeName]))
      ..fontSize = 14,
    if(storeName != "") ElevatedButton(
      onPressed: detach,
      child: n.Text(dict(31, lang))
    )
  ])
    ..spacing = 15
    ..direction = Axis.vertical
    ..center
    ..n.center;
}