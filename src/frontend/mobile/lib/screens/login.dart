// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:PharmaControl/api/user.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/screens/admin/home.dart';
import 'package:PharmaControl/screens/auxiliar/home.dart';
import 'package:PharmaControl/screens/enfermeiro/home.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _inAsyncCall = false;

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
        body: ModalProgressHUD(
          inAsyncCall: _inAsyncCall,
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // logo
                  Image.asset(
                    'lib/assets/logo.png',
                    width: 250,
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
      ),
    );
  }

  void _asyncCall() async {
    setState(() {
      _inAsyncCall = !_inAsyncCall;
    });
  }

  void _login(context) async {
    _asyncCall();
    Map<dynamic, dynamic> user =
        await login(userController.text, passwordController.text);
    _asyncCall();
    if (user["user"] == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha no login!'),
        ),
      );
      return;
    }
    String role = user["role"];
    if (role == "ADMIN") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminHome()),
      );
    } else if (role == "ASSISTANT") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuxHome()),
      );
    } else if (role == "NURSE") {
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Material(
        color: Color.fromARGB(255, 220, 217, 217),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                "Acessar",
                style: TextStyle(
                  fontSize: 25,
                  color: hsDarkBlueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: hsLightBlueColor,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: hsGrayColor,
          ),
        ),
      ),
    );
  }
}
