import 'package:flutter/material.dart';
import 'widgets/login_page.dart';
import 'screens/admin/home.dart';
import 'package:mobile/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Login',
      home: Splash(),
    );
  }
}





