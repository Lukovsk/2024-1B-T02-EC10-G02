import 'package:flutter/material.dart';
import 'package:PharmaControl/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:PharmaControl/screens/enfermeiro/page_state.dart';
import 'package:PharmaControl/screens/enfermeiro/order_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageState()),
        ChangeNotifierProvider(create: (context) => OrderState()),
      ],
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
