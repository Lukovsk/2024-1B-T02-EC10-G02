// ignore_for_file: prefer_const_constructors

import 'package:PharmaControl/api/order.dart';
import 'package:PharmaControl/models/order.dart';
import 'package:PharmaControl/screens/auxiliar/home.dart';
import 'package:PharmaControl/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AuxOrders extends StatefulWidget {
  const AuxOrders({super.key});

  @override
  State<AuxOrders> createState() => AuxOrdersState();
}

class AuxOrdersState extends State<AuxOrders> {
  int _currentIndex = 1;
  List<Order> orderList = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

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
                  for (Order order in orderList.reversed)
                    OrderCard(
                      title: order.medicine ?? "",
                      status: order.status ?? false,
                      date: order.createdAt ?? DateTime.now().toString(),
                      canceled: order.canceled ?? true,
                      pyxis: order.pyxis ?? 12,
                      sector: order.sector ?? "B",
                      rating: ((order.rating ?? 10) % 10),
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

  void fetchOrders() async {
    final orders = await getOrders();
    setState(() {
      orderList = orders;
    });
  }
}

class OrderCard extends StatelessWidget {
  final String title;
  final bool status;
  final bool canceled;
  final String date;
  final int pyxis;
  final String sector;
  final int rating;

  const OrderCard({
    super.key,
    required this.title,
    required this.status,
    required this.canceled,
    required this.date,
    required this.pyxis,
    required this.sector,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    String statusMessage = canceled
        ? "Pedido Cancelado"
        : status
            ? "Pedido Concluído"
            : "Pedido em andamento";

    Color statusColor = canceled
        ? Colors.red
        : status
            ? Colors.green
            : Colors.deepOrange;

    IconData statusIcon = canceled
        ? Icons.cancel
        : status
            ? Icons.check_circle
            : Icons.pending;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                      statusMessage,
                      style: TextStyle(color: statusColor),
                    ),
                    SizedBox(width: 4),
                    Icon(statusIcon, color: statusColor),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Data: $date'),
                Text('Pyxis: $pyxis'),
                Text('Setor: $sector'),
              ],
            ),
            Divider(),
            Text('Avaliação'),
            RatingBar.builder(
              initialRating: rating.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
              itemSize: 24,
              ignoreGestures: true,
            ),
          ],
        ),
      ),
    );
  }
}
