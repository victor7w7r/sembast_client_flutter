import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;
import 'package:riverpod_context/riverpod_context.dart';

import 'package:sembast_client_flutter/config/index.dart';
import 'package:sembast_client_flutter/providers/index.dart';

class AddTab extends StatelessWidget {

  const AddTab({super.key});

  @override
  Widget build(context) {

    final lang = context.watch(langProvider);

    return n.Stack([
      n.Text(dict(34, lang))
        ..bold
        ..n.top = 60
        ..n.left = 35
        ..fontSize = 35,
    ]);
  }
}