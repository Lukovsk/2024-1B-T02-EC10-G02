// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:PharmaControl/screens/auxiliar/home.dart';
import 'package:PharmaControl/screens/enfermeiro/order_state.dart';
import 'package:PharmaControl/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:PharmaControl/screens/auxiliar/pharma_control_card.dart';

class AuxOrders extends StatefulWidget {
  const AuxOrders({super.key});

  @override
  State<AuxOrders> createState() => _AuxOrdersState();
}

class _AuxOrdersState extends State<AuxOrders> {
  int _currentIndex = 1;

  void _bottomNavOnTap(int index) {
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
  Widget build(BuildContext context) {
    var orders = context.watch<OrderState>().orders;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar pedido',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  var order = orders[index];
                  return PharmaControlCard(
                    title: order.material.isNotEmpty ? order.material : order.problema,
                    idMedicamento: "1234543",  // substitua com os dados reais
                    quantidade: "20 unidades",  // substitua com os dados reais
                    pontoReferencia: "Ala-pediátrica",  // substitua com os dados reais
                    onAccepted: () {
                      // lógica de aceitação
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pedido aceito')));
                    },
                    onDeclined: () {
                      // lógica de recusa
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pedido recusado')));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _bottomNavOnTap,
      ),
    );
  }
}
