import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2563AF),
              Color(0xFF3D97D3),
            ],
          ),
        ),
      ),
      title: Column(
        children: [
          Image.asset(
            'lib/assets/logo.png',
            height: 55.0,
          ),
          const SizedBox(height: 15.0),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }
}
