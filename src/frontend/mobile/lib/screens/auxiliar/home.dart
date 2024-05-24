// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/widgets/custom_app_bar.dart';
import '/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/screens/admin/home.dart';

class AuxHome extends StatefulWidget {
  AuxHome({super.key});

  @override
  State<AuxHome> createState() => _HomeState();
}

class _HomeState extends State<AuxHome> {
  int _currentIndex = 0;
  bool _notificationAllowed = false;
  bool _hasNotification = false;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuxHome()),
        );
        break;
      case 1:
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => Dashboard()),
        // );
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: _hasNotification ? _buildNotified() : _buildUnNotified(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }

  Container _buildNotified() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Atendimento solicitado",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Divider(
                color: hsNiceBlueColor,
                thickness: 6,
              ),
            ],
          ),
          AuxRequestedOrder()
        ],
      ),
    );
  }

  Container _buildUnNotified() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icone gigante
          Icon(
            _notificationAllowed
                ? Icons.alarm_on_rounded
                : Icons.alarm_off_rounded,
            size: 120,
            color: hsGreyColor,
          ),

          // Titulozinho
          Text(
            _notificationAllowed ? "Disponível" : "Indisponivel",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Textinho
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Text(
              _notificationAllowed
                  ? "Nenhum pedido solicitado. Para ficar indisponível basta clicar no botão"
                  : "No momento você não está recebendo alertas de atendimento. para ficar disponivel basta clicar no botão",
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
          ),

          // Botãozinho
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  right: 40,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _notificationAllowed = !_notificationAllowed;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hsNiceBlueColor,
                    minimumSize: Size(60, 80),
                    elevation: 10,
                  ),
                  child: Icon(
                    _notificationAllowed
                        ? Icons.notifications_off_rounded
                        : Icons.notifications_on_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AuxRequestedOrder extends StatelessWidget {
  const AuxRequestedOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            top: BorderSide(
              color: hsYellowColor,
              width: 24,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 4),
            )
          ]),
      padding: EdgeInsets.only(
        top: 20,
        bottom: 12,
        left: 10,
        right: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: hsBlackColor,
                        ),
                      ),
                      child: Icon(
                        Icons.medical_services_rounded,
                        color: hsBlackColor,
                        size: 40,
                      ),
                    ),
                    Text(
                      "Pyxi - 12B",
                      style: TextStyle(
                        fontSize: 14,
                        color: hsBlackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ID medicamento: 1234543",
                      style: TextStyle(
                        fontSize: 10,
                        color: hsBlackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Quantidade: 20 unidades",
                      style: TextStyle(
                        fontSize: 10,
                        color: hsBlackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Ponto de referência: Ala-pediátrica",
                      style: TextStyle(
                        fontSize: 10,
                        color: hsBlackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(hsGreenColor),
                  fixedSize: MaterialStatePropertyAll<Size>(Size(120, 0)),
                ),
                child: Text(
                  "Aceitar",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(hsRedColor),
                  fixedSize: MaterialStatePropertyAll<Size>(Size(120, 0)),
                ),
                child: Text(
                  "Negar",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
