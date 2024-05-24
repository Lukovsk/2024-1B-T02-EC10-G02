import 'package:flutter/material.dart';
import 'package:PharmaControl/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:PharmaControl/screens/enfermeiro/page_state.dart';
import 'package:PharmaControl/screens/enfermeiro/request_page.dart';
import 'package:PharmaControl/widgets/enfermeiro/text_field.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PageState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Login',
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
