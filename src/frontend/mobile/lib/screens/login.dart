// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile/api/user.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/screens/admin/home.dart';
import 'package:mobile/screens/auxiliar/home.dart';
import 'package:mobile/screens/enfermeiro/home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            hsLightBlueColor,
            hsBlueColor,
            hsDarkBlueColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // logo
                Image.asset(
                  'lib/assets/logo.png',
                  width: 300,
                ),
                // Faça seu login
                Text(
                  "Faça seu login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // user
                LoginTextField(
                  controller: userController,
                  hintText: "Usuário",
                  obscureText: false,
                ),

                // password
                LoginTextField(
                  controller: passwordController,
                  hintText: "Senha",
                  obscureText: true,
                ),

                // forgot password?
                ForgotPasswordButton(
                  onTap: () {},
                ),

                // login
                LoginButton(
                  onTap: () {
                    _login(context);
                  },
                ),

                SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login(context) async {
    Map<dynamic, dynamic> user =
        await login(userController.text, passwordController.text);

    if (user["name"] == "Administrador") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminHome()),
      );
    } else if (user["name"] == "Auxiliar") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuxHome()),
      );
    } else if (user["name"] == "Enfermeiro") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha no login!'),
        ),
      );
    }
  }
}

class ForgotPasswordButton extends StatelessWidget {
  final Function()? onTap;

  const ForgotPasswordButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              "Esqueceu sua senha?",
              style: TextStyle(
                color: hsGrayColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Function()? onTap;

  const LoginButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: hsLightBlueColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: hsRedColor,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
