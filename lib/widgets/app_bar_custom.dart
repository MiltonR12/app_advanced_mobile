import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarCustom({super.key, this.title = "Mi Aplicación"});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title), backgroundColor: Colors.cyan);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
