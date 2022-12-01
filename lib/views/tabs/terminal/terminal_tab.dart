import 'package:flutter/material.dart';

import 'package:niku/namespace.dart' as n;

class TerminalTab extends StatelessWidget {

  const TerminalTab({super.key});

  @override
  Widget build(context) {

    return n.Stack([
      n.Text("Terminal")
        ..bold
        ..n.top = 60
        ..n.left = 35
        ..fontSize = 35,
    ]);
  }
}