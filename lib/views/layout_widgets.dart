import 'package:flutter/material.dart';

import 'package:sembast_client_flutter/views/tabs/home/home_tab.dart';

final tabs = [
  const HomeTab(),
  Container(),
  Container(),
  Container(),
  Container(),
  Container(),
];

List<Widget> iconsTab(bool isDark) => [
  Icon(Icons.home, size: 30, color: isDark ? Colors.white : Colors.black),
  Icon(Icons.read_more, size: 30, color: isDark ? Colors.white : Colors.black),
  Icon(Icons.add, size: 30, color: isDark ? Colors.white : Colors.black),
  Icon(Icons.update, size: 30, color: isDark ? Colors.white : Colors.black),
  Icon(Icons.delete, size: 30, color: isDark ? Colors.white : Colors.black),
  Icon(Icons.terminal, size: 30, color: isDark ? Colors.white : Colors.black),
];