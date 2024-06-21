// import 'dart:ffi';

// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:PharmaControl/api/order.dart' as order_api;
import 'package:PharmaControl/models/order.dart';
import 'package:PharmaControl/screens/auxiliar/order.dart';
import 'package:PharmaControl/screens/auxiliar/orders.dart';
import 'package:flutter/material.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/globals.dart' as globals;
import 'package:PharmaControl/widgets/custom_app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '/widgets/bottom_navigation_bar.dart';

class AuxHome extends StatefulWidget {
  const AuxHome({super.key});

  @override
  State<AuxHome> createState() => _HomeState();
}

class _HomeState extends State<AuxHome> {
  // ? Será que não é melhor colocar isso buildin no bottom navigation bar?
  int _currentIndex = 0;
  bool _inAsyncCall = false;

  bool _notificationAllowed = true;
  bool _hasNotification = false;
  Order? _order;

  void _asyncCall() async {
    setState(() {
      _inAsyncCall = !_inAsyncCall;
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
          MaterialPageRoute(builder: (context) => const AuxHome()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuxOrders()),
        );
        break;
      default:
        break;
    }
  }

  void fetchLastOrder() async {
    _asyncCall();
    final data = await order_api.fetchLastOrder();
    if (data != null) {
      setState(() {
        _order = data;
        _notificationAllowed = true;
        _hasNotification = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Há nenhum pedido novo!'),
        ),
      );
      setState(() {
        _notificationAllowed = true;
        _hasNotification = false;
      });
    }
    _asyncCall();
  }

  void _onOrderAccepted() async {
    _asyncCall();
    if (await order_api.acceptOrder(globals.user!.id!, _order!.id)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OrderDetail(order: _order!)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Erro ao aceitar o pedido!'),
      ));
    }
    _asyncCall();
  }

  // TODO: integrando, deve fazer com que um outro auxiliar receba uma notificação (ideal guardar a informação que o pedido foi negado e por quem)
  void _onOrderDenied() {
    setState(() {
      _hasNotification = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLastOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: ModalProgressHUD(
          inAsyncCall: _inAsyncCall,
          child:
              _hasNotification ? _buildNotified(_order!) : _buildUnNotified()),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }

  Container _buildNotified(Order order) => Container(
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
              order: order,
            ),
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
                        ? "Nenhum pedido solicitado. Para verificar se há algum pedido solicitado, basta clicar no botão"
                        : "No momento você não está recebendo alertas de atendimento. Para ficar disponivel basta clicar no botão",
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
                    onPressed: fetchLastOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hsNiceBlueColor,
                      minimumSize: const Size(60, 80),
                      elevation: 10,
                    ),
                    child: Icon(
                      _notificationAllowed
                          ? Icons.replay_outlined
                          : Icons.replay_outlined,
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
  final Order order;

  const AuxRequestedOrder({
    super.key,
    required this.onAccepted,
    required this.onDenied,
    required this.order,
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
                    Text(
                      "Pyxi - ${order.pyxis?.name}",
                      style: const TextStyle(
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
                      "Problema: ${order.problem}",
                      style: TextStyle(
                        fontSize: 10,
                        color: hsBlackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      order.problem == "estoque"
                          ? "${order.item?.name}"
                          : "${order.description}",
                      style: TextStyle(
                        fontSize: 10,
                        color: hsBlackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Referência: ${order.pyxis?.reference}",
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
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(hsGreenColor),
                  fixedSize: MaterialStateProperty.all<Size>(Size(120, 0)),
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
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith((states) => tdRed),
                  fixedSize: MaterialStateProperty.all<Size>(Size(120, 0)),
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
