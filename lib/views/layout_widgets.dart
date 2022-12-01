import 'package:flutter/material.dart';

import 'package:conditioned/conditioned.dart';

import 'package:sembast_client_flutter/utils/index.dart';
import 'package:sembast_client_flutter/views/tabs/add/add_tab.dart';
import 'package:sembast_client_flutter/views/tabs/delete/delete_tab.dart';
import 'package:sembast_client_flutter/views/tabs/home/home_tab.dart';
import 'package:sembast_client_flutter/views/tabs/read/read_tab.dart';
import 'package:sembast_client_flutter/views/tabs/terminal/terminal_tab.dart';
import 'package:sembast_client_flutter/views/tabs/update/update_tab.dart';

class BodyBuilder extends StatelessWidget {
  const BodyBuilder({
    super.key,
    required this.isStore,
    required this.index
  });

  final bool isStore;
  final int index;

  @override
  Widget build(context) => isStore ? Conditioned(
    cases: [
      Case(index == 0, builder: HomeTab.new),
      Case(index == 1, builder: ReadTab.new),
      Case(index == 2, builder: AddTab.new),
      Case(index == 3, builder: UpdateTab.new),
      Case(index == 4, builder: DeleteTab.new),
      Case(index == 5 && isDesktop, builder: TerminalTab.new)
    ],
    defaultBuilder: Container.new
  ) : Conditioned(
    cases: [
      Case(index == 0, builder: HomeTab.new),
      Case(index == 1 && isDesktop, builder: TerminalTab.new)
    ],
    defaultBuilder: Container.new
  );
}

List<BottomNavigationBarItem> dbLoadedIconsTab(bool isDark, bool lang) => [
  BottomNavigationBarItem(
    icon: Icon(Icons.home, size: 30, color: isDark ? Colors.white : Colors.black),
    label: lang ? 'Home' : 'Inicio',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.read_more, size: 30, color: isDark ? Colors.white : Colors.black),
    label:  lang ? 'Read' : 'Leer',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.add, size: 30, color: isDark ? Colors.white : Colors.black),
    label: lang ? 'Add' : 'Agregar',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.update, size: 30, color: isDark ? Colors.white : Colors.black),
    label: lang ? 'Update' : 'Actualizar',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.delete, size: 30, color: isDark ? Colors.white : Colors.black),
    label: lang ? 'Delete' : 'Eliminar',
  ),
  if(isDesktop) BottomNavigationBarItem(
    icon: Icon(Icons.terminal, size: 30, color: isDark ? Colors.white : Colors.black),
    label: 'Terminal',
  )
];

List<BottomNavigationBarItem> iconsTab(bool isDark, bool lang) => [
  BottomNavigationBarItem(
    icon: Icon(Icons.home, size: 30, color: isDark ? Colors.white : Colors.black),
    label: lang ? 'Home' : 'Inicio',
  ),
  if(isDesktop) BottomNavigationBarItem(
    icon: Icon(Icons.terminal, size: 30, color: isDark ? Colors.white : Colors.black),
    label: 'Terminal',
  )
];