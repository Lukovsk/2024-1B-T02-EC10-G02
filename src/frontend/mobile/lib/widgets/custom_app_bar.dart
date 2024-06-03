// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:PharmaControl/screens/login.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? hamburguerOnTap;

  const CustomAppBar({
    super.key,
    this.hamburguerOnTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: tdGradient,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Image.asset(
              'lib/assets/logo.png',
              height: 55.0,
            ),
          ),
          if (hamburguerOnTap != null)
            IconButton(
              onPressed: hamburguerOnTap,
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 40,
              ),
            ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }
}
