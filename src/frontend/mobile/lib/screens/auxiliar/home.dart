// import 'dart:ffi';

import 'package:PharmaControl/models/order.dart';
import 'package:PharmaControl/screens/auxiliar/order.dart';
import 'package:PharmaControl/screens/auxiliar/orders.dart';
import 'package:flutter/material.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/widgets/custom_app_bar.dart';
import '/widgets/bottom_navigation_bar.dart';

class AuxHome extends StatefulWidget {
  const AuxHome({super.key});

  @override
  State<AuxHome> createState() => _HomeState();
}

class _HomeState extends State<AuxHome> {
  // ? Será que não é melhor colocar isso buildin no bottom navigation bar?
  int _currentIndex = 0;

  bool _notificationAllowed = false;
  bool _hasNotification = false;

  // TODO: deve haver um push notification que altera automaticamente para "requisição recebida"
  void _hamburguerOnTap() {
    setState(() {
      _hasNotification = !_hasNotification;
    });
  }

  // ? Será que não é melhor colocar isso buildin no bottom navigation bar?
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuxOrders()),
        );
        break;
      default:
        break;
    }
  }

  // TODO: integrando, deve alterar o estado do auxiliar (faz uma requisição ao controller para alterar o estado dele)
  void changeAllowNotification() {
    setState(() {
      _notificationAllowed = !_notificationAllowed;
    });
  }

  // TODO: integrando, deve alterar o estado do pedido na fila, colocando que há um auxiliar que fará o pedido
  void _onOrderAccepted() {
    final order = Order.getExample();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OrderDetail(order: order)),
    );
  }

  // TODO: integrando, deve fazer com que um outro auxiliar receba uma notificação (ideal guardar a informação que o pedido foi negato e por quem)
  void _onOrderDenied() {
    setState(() {
      _hasNotification = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        hamburguerOnTap: _hamburguerOnTap,
      ),
      body: _hasNotification ? _buildNotified() : _buildUnNotified(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }

  Container _buildNotified() => Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    "Atendimento solicitado",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(
                  color: hsNiceBlueColor,
                  thickness: 6,
                ),
              ],
            ),
            AuxRequestedOrder(
              onAccepted: _onOrderAccepted,
              onDenied: _onOrderDenied,
            )
          ],
        ),
      );

  Container _buildUnNotified() => Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icone gigante
            Column(
              children: [
                Icon(
                  _notificationAllowed
                      ? Icons.alarm_on_rounded
                      : Icons.alarm_off_rounded,
                  size: 120,
                  color: hsGreyColor,
                ),
                Text(
                  _notificationAllowed ? "Disponível" : "Indisponivel",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Textinho
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Text(
                    _notificationAllowed
                        ? "Nenhum pedido solicitado. Para ficar indisponível basta clicar no botão"
                        : "No momento você não está recebendo alertas de atendimento. para ficar disponivel basta clicar no botão",
                    textAlign: TextAlign.center,
                    style: const TextStyle(),
                  ),
                ),
              ],
            ),

            // Titulozinho

            // Botãozinho
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    right: 40,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: changeAllowNotification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hsNiceBlueColor,
                      minimumSize: const Size(60, 80),
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

class AuxRequestedOrder extends StatelessWidget {
  final Function() onAccepted;
  final Function() onDenied;

  const AuxRequestedOrder({
    super.key,
    required this.onAccepted,
    required this.onDenied,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: const Border(
            top: BorderSide(
              color: hsYellowColor,
              width: 24,
            ),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 4),
            )
          ]),
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 12,
        left: 10,
        right: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: hsBlackColor,
                        ),
                      ),
                      child: const Icon(
                        Icons.medical_services_rounded,
                        color: hsBlackColor,
                        size: 40,
                      ),
                    ),
                    const Text(
                      "Pyxi - 12B",
                      style: TextStyle(
                        fontSize: 14,
                        color: hsBlackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const Column(
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
                onPressed: onAccepted,
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(hsGreenColor),
                  fixedSize: WidgetStatePropertyAll<Size>(Size(120, 0)),
                ),
                child: const Text(
                  "Aceitar",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: onDenied,
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(hsRedColor),
                  fixedSize: WidgetStatePropertyAll<Size>(Size(120, 0)),
                ),
                child: const Text(
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
