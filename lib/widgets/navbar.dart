import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {

  const NavBar({
    super.key,
    required this.index,
    required this.isDark,
    required this.onTap,
    required this.items,
  });

  final int index;
  final bool isDark;
  final void Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(context) => BottomNavigationBar(
    backgroundColor: Colors.transparent,
    fixedColor: Colors.transparent,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    currentIndex: index,
    onTap: onTap,
    items: items
  );

}