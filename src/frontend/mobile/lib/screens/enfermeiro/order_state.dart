import 'package:flutter/material.dart';

class Order {
  final String problema;
  final String pyxis;
  final String material;
  final String status;
  final String date;
  final int rating;
  bool avaliacaoPreenchida;
  final String aditionalInfo;

  Order({
    required this.problema,
    required this.pyxis,
    required this.material,
    required this.status,
    required this.date,
    required this.rating,
    this.avaliacaoPreenchida = false,
    this.aditionalInfo = '',
  });
}

class OrderState with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  void preencherAvaliacao(Order order) {
    order.avaliacaoPreenchida = true;
    notifyListeners();
  }
}
