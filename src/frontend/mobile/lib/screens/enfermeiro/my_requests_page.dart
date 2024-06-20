// import 'package:PharmaControl/models/order.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:PharmaControl/widgets/bottom_navigation_bar.dart';
// import 'package:PharmaControl/screens/enfermeiro/home.dart';
// import 'package:PharmaControl/screens/enfermeiro/page_state.dart';
// import 'package:provider/provider.dart';
// import 'package:PharmaControl/screens/enfermeiro/order_state.dart';
// import 'package:PharmaControl/screens/enfermeiro/rate_page.dart';
// import 'package:PharmaControl/screens/auxiliar/home.dart';

// class OrderScreen extends StatefulWidget {
//   @override
//   _OrderScreen createState() => _OrderScreen();
// }

// class _OrderScreen extends State<OrderScreen> {
//   void _onTap(int index) {
//     context.read<PageState>().setIndex(index);

//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => Home()),
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => OrderScreen()),
//         );
//         break;
//       case 2:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const AuxHome()),
//         );
//         break;
//       default:
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     int _currentIndex = context.watch<PageState>().currentIndex;
//     var orders = context.watch<Order>().orders;
//     return Scaffold(
//       appBar: AppBar(
//         title:
//             const Text('Meus Pedidos', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Pesquisar pedido',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: orders.length,
//                 itemBuilder: (context, index) {
//                   var order = orders[index];
//                   return OrderCard(
//                     order: order,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onTap,
//       ),
//     );
//   }
// }

// class OrderCard extends StatelessWidget {
//   final Order order;

//   OrderCard({required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   order.item != null
//                       ? "${order.item?.name}"
//                       : "${order.description}",
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       order.status!,
//                       style: TextStyle(
//                           color: order.status == 'Pedido Concluído'
//                               ? Colors.green
//                               : Colors.red),
//                     ),
//                     const SizedBox(width: 4),
//                     Icon(
//                         order.status == 'Pedido Concluído'
//                             ? Icons.check_circle
//                             : Icons.cancel,
//                         color: order.status == 'Pedido Concluído'
//                             ? Colors.green
//                             : Colors.red),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Data: ${order.createdAt}'),
//                 Text('Pyxis: ${order.pyxis}'),
//                 const Text('Setor: 12B'),
//               ],
//             ),
//             const Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     const Text('Avaliação'),
//                     RatingBar.builder(
//                       initialRating: order.rating!.toDouble(),
//                       minRating: 1,
//                       direction: Axis.horizontal,
//                       allowHalfRating: true,
//                       itemCount: 5,
//                       itemBuilder: (context, _) => const Icon(
//                         Icons.star,
//                         color: Colors.amber,
//                       ),
//                       onRatingUpdate: (rating) {},
//                       itemSize: 24,
//                       ignoreGestures: true,
//                     ),
//                   ],
//                 ),
//                 if (order.rating == 0)
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AvaliacaoPage(order: order),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                     ),
//                     child: const Text('Avaliar',
//                         style: TextStyle(color: Colors.white)),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
