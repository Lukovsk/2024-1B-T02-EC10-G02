// ignore_for_file: prefer_const_constructors

import 'package:PharmaControl/screens/auxiliar/home.dart';
import 'package:PharmaControl/screens/enfermeiro/my_requests_page.dart';
import 'package:PharmaControl/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AuxOrders extends StatefulWidget {
  const AuxOrders({super.key});

  @override
  State<AuxOrders> createState() => Aux_OrdersState();
}

class Aux_OrdersState extends State<AuxOrders> {
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
              child: ListView(
                children: [
                  OrderCard(
                    title: 'Dipirona',
                    status: 'Pedido Concluído',
                    statusColor: Colors.green,
                    statusIcon: Icons.check_circle,
                    date: '22/03/2024',
                    pyxis: '3',
                    sector: '12B',
                    rating: 4,
                  ),
                  OrderCard(
                    title: 'Morfina',
                    status: 'Pedido Cancelado',
                    statusColor: Colors.red,
                    statusIcon: Icons.cancel,
                    date: '22/03/2024',
                    pyxis: '3',
                    sector: '12B',
                    rating: 2,
                  ),
                  OrderCard(
                    title: 'Paracetamol',
                    status: 'Pedido Cancelado',
                    statusColor: Colors.red,
                    statusIcon: Icons.cancel,
                    date: '22/03/2024',
                    pyxis: '1',
                    sector: '12B',
                    rating: 1,
                  ),
                  OrderCard(
                    title: 'Dipirona',
                    status: 'Pedido Concluído',
                    statusColor: Colors.green,
                    statusIcon: Icons.check_circle,
                    date: '22/03/2024',
                    pyxis: '4',
                    sector: '12B',
                    rating: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex, onTap: _bottomNavOnTap),
    );
  }
}
