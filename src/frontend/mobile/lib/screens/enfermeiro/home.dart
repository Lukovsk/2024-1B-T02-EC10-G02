import 'package:PharmaControl/api/order.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/models/order.dart';
import 'package:PharmaControl/screens/enfermeiro/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '/widgets/custom_app_bar.dart';
import '/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/screens/enfermeiro/request_page.dart';
import 'package:PharmaControl/widgets/enfermeiro/my_requests_card.dart';
import 'package:PharmaControl/models/page_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _onTap(int index) {
    context.read<PageState>().setIndex(index);
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NurseOrders()),
        );
        break;
      case 2:
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const AuxHome()),
        // );
        break;
      default:
        break;
    }
  }

  bool _inAsyncCall = false;
  List<Order> orderList = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void _asyncCall() {
    setState(() {
      _inAsyncCall = !_inAsyncCall;
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = context.watch<PageState>().currentIndex;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: ModalProgressHUD(
        inAsyncCall: _inAsyncCall,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Pesquisar medicamento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.grey[600]!,
                      width: 1.0,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              MyRequestsCard(),
              Expanded(
                child: orderList.isNotEmpty
                    ? ListView(
                        children: [
                          if (orderList.isNotEmpty)
                            for (Order order in orderList.reversed)
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
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.done_outline_rounded,
                            size: 120,
                            color: hsGreenColor,
                          ),
                          Text(
                            "Nenhum pedido em andamento!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: _requestOrder,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Nova Solicitação',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563AF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onTap,
      ),
    );
  }

  void _requestOrder() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RequestPage()),
    );
  }

  void fetchOrders() async {
    _asyncCall();
    final orders = await getOrders();
    if (orders != null) {
      setState(() {
        _inAsyncCall = !_inAsyncCall;
        orderList = orders
            .where((item) => item.status != "DONE" && item.status != "CANCELED")
            .toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha buscando pedidos!'),
        ),
      );
    }
  }
}
