import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:PharmaControl/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/screens/enfermeiro/home.dart';
import 'package:PharmaControl/screens/enfermeiro/page_state.dart';
import 'package:provider/provider.dart';
import 'package:PharmaControl/screens/enfermeiro/order_state.dart';
import 'package:PharmaControl/screens/enfermeiro/rate_page.dart';
import 'package:PharmaControl/screens/auxiliar/home.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreen createState() => _OrderScreen();
}

class _OrderScreen extends State<OrderScreen> {
  void _onTap(int index) {
    context.read<PageState>().setIndex(index);

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrderScreen()),
        );
        break;
      case 2:
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuxHome()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = context.watch<PageState>().currentIndex;
    var orders = context.watch<OrderState>().orders;
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos', style: TextStyle(color: Colors.white)),
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
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  var order = orders[index];
                  return OrderCard(
                    order: order,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({required this.order});

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
                    order.material.isNotEmpty ? order.material : order.problema,
                
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                      order.status,
                      style: TextStyle(color: order.status == 'Pedido Concluído' ? Colors.green : Colors.red),
                    ),
                    SizedBox(width: 4),
                    Icon(order.status == 'Pedido Concluído' ? Icons.check_circle : Icons.cancel, color: order.status == 'Pedido Concluído' ? Colors.green : Colors.red),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Data: ${order.date}'),
                Text('Pyxis: ${order.pyxis}'),
                Text('Setor: 12B'),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Avaliação'),
                    RatingBar.builder(
                      initialRating: order.rating.toDouble(),
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
                if (!order.avaliacaoPreenchida)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AvaliacaoPage(order: order),
                        ),
                      );
                    },
                    child: Text('Avaliar', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
