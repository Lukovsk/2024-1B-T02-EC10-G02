// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PharmaControl/api/order.dart';
import 'package:PharmaControl/models/order.dart';
import 'package:PharmaControl/screens/auxiliar/home.dart';
import 'package:PharmaControl/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../models/pyxis.dart';

class AuxOrders extends StatefulWidget {
  const AuxOrders({super.key});

  @override
  State<AuxOrders> createState() => AuxOrdersState();
}

class AuxOrdersState extends State<AuxOrders> {
  bool _inAsyncCall = false;
  int _currentIndex = 1;
  List<Order> orderList = [];
  List<Order> _foundOrders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
    _foundOrders = orderList;
  }

  void _inAsync() {
    setState(() {
      _inAsyncCall = !_inAsyncCall;
    });
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
      body: ModalProgressHUD(
        inAsyncCall: _inAsyncCall,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => _runFilter(value),
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
                    for (Order order in _foundOrders.reversed)
                      OrderCard(
                        title: order.problem == "estoque"
                            ? order.item!.name
                            : "Problema técnico",
                        status: order.status!,
                        date: order.createdAt!,
                        canceled: order.canceled!,
                        pyxis: order.pyxis!,
                        rating: ((order.rating ?? 10) % 10),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _bottomNavOnTap,
      ),
    );
  }

  void fetchOrders() async {
    _inAsync();
    final orders = await getOrders();
    if (orders != null) {
      setState(() {
        _inAsyncCall = !_inAsyncCall;
        orderList = orders;
        _foundOrders = orders;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha buscando pedidos!'),
        ),
      );
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Order> results = [];
    if (enteredKeyword.isEmpty) {
      results = orderList;
    } else {
      results = orderList
          .where((item) =>
              (item.problem == "estoque" ? item.item!.name : "Problema técnico")
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundOrders = results;
    });
  }
}

class OrderCard extends StatelessWidget {
  final String title;
  final String status;
  final bool canceled;
  final String date;
  final Pyxis pyxis;
  final int rating;

  OrderCard({
    super.key,
    required this.title,
    required this.status,
    required this.canceled,
    required this.date,
    required this.pyxis,
    required this.rating,
  });

  final Map<String, List<dynamic>> statuses = {
    "PENDING": [
      "Pedido em andamento",
      Colors.deepOrange,
      Icons.pending,
    ],
    "DONE": [
      "Pedido Concluído",
      Colors.green,
      Icons.check_circle,
    ],
    "CANCELED": [
      "Pedido Cancelado",
      Colors.red,
      Icons.cancel,
    ],
    "ACCEPTED": [
      "Pedido aceito",
      Colors.deepOrange,
      Icons.pending,
    ],
  };

  @override
  Widget build(BuildContext context) {
    String statusMessage = statuses[status]![0];

    Color statusColor = statuses[status]![1];

    IconData statusIcon = statuses[status]![2];

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
                Text('Pyxis: ${pyxis.name}'),
                Text('Setor: ${pyxis.sector}'),
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
