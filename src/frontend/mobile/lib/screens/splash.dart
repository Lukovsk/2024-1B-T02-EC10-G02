import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:PharmaControl/screens/enfermeiro/home.dart';
import '../constants/colors.dart';

class Splash extends StatelessWidget {
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
          nextScreen: Home(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.transparent, 
        ),
      ),
    );
  }
}
