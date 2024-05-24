import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
        backgroundColor: Colors.blue,
      ),
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
                    title: 'Dipirona',
                    status: 'Pedido Cancelado',
                    statusColor: Colors.red,
                    statusIcon: Icons.cancel,
                    date: '22/03/2024',
                    pyxis: '3',
                    sector: '12B',
                    rating: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;
  final IconData statusIcon;
  final String date;
  final String pyxis;
  final String sector;
  final int rating;

  OrderCard({
    required this.title,
    required this.status,
    required this.statusColor,
    required this.statusIcon,
    required this.date,
    required this.pyxis,
    required this.sector,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
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
                      status,
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
