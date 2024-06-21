import 'package:flutter/material.dart';
import 'package:PharmaControl/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:PharmaControl/models/page_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tela de Login',
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
