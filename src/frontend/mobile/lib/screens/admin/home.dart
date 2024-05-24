// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:PharmaControl/screens/admin/dashboard.dart';
import 'package:PharmaControl/widgets/custom_app_bar.dart';
import '../../constants/colors.dart';

class AdminHome extends StatefulWidget {
  AdminHome({super.key});

  @override
  State<AdminHome> createState() => _HomeState();
}

class _HomeState extends State<AdminHome> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminHome()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                children: [
                  // Title
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Text(
                      "Dados de Atendimentos",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Search box
                  _buildSearchBox(),

                  SizedBox(height: 20),
                  // Orders
                  Expanded(
                    child: ListView(
                      children: [
                        OrderItem(),
                        OrderItem(),
                        OrderItem(),
                        OrderItem(),
                        OrderItem(),
                        OrderItem(),
                        OrderItem(),
                        OrderItem(),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: AdCustomBottomNavigationBar(
            currentIndex: _currentIndex, onTap: _onTap));
  }

  Container _buildSearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: hsBlackColor,
            size: 25,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 25,
            minWidth: 50,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: "Pesquisar atendimento",
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  _runFilter(String value) {}
}

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 4),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        tileColor: Colors.white,
        leading: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: hsBlackColor,
            ),
          ),
          child: Icon(
            Icons.medical_services_rounded,
            color: hsBlackColor,
            size: 30,
          ),
        ),
        title: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pyxi - 12B",
                style: TextStyle(
                  fontSize: 15,
                  color: hsBlackColor,
                ),
              ),
              Column(
                children: [
                  Text(
                    "22/05/2024",
                    style: TextStyle(
                      fontSize: 10,
                      color: hsBlackColor,
                    ),
                  ),
                  Text(
                    "Em andamento",
                    style: TextStyle(
                      fontSize: 10,
                      color: hsBlackColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "16:52",
                    style: TextStyle(
                      fontSize: 10,
                      color: hsBlackColor,
                    ),
                  ),
                  Text(
                    "João",
                    style: TextStyle(
                      fontSize: 10,
                      color: hsBlackColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AdCustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AdCustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_graph_rounded),
          label: 'Dashboard',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Color(0xFF2563AF),
      unselectedItemColor: Colors.grey,
      onTap: onTap,
    );
  }
}
