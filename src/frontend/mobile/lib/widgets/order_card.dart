// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PharmaControl/models/pyxis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
