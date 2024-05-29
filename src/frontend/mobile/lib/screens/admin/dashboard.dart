import 'package:flutter/material.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/screens/admin/home.dart';
import 'package:PharmaControl/widgets/custom_app_bar.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashState();
}

class _DashState extends State<Dashboard> {
  int _currentIndex = 1;

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
      backgroundColor: tdBGColor,
      appBar: CustomAppBar(),
      body: const Text("Heelo from dashborad"),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentIndex: _currentIndex, onTap: _onTap),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
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
