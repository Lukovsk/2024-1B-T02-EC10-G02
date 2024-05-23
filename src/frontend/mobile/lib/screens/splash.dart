import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mobile/screens/enfermeiro/home.dart';
import 'package:mobile/screens/login.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
