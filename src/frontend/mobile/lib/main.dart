import 'package:flutter/material.dart';
import 'package:mobile/screens/splash.dart';
import 'package:mobile/screens/enfermeiro/request_page.dart';

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
