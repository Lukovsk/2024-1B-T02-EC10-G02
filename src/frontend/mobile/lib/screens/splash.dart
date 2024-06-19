import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:PharmaControl/screens/login.dart';
import '../constants/colors.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: tdGradient,
        ),
        child: AnimatedSplashScreen(
          duration: 3000,
          splash: Image.asset('lib/assets/logo.png'),
          nextScreen: LoginPage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
