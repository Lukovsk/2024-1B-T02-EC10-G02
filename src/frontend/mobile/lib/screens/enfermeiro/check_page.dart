import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PharmaControl/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/screens/enfermeiro/home.dart';
import 'package:PharmaControl/screens/enfermeiro/page_state.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:lottie/lottie.dart';


class CheckGif extends StatelessWidget {
  const CheckGif({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('lib/assets/videos/check.json');
  }
}

class CheckPage extends StatefulWidget {
  @override
  _CheckPage createState() => _CheckPage();
}

class _CheckPage extends State<CheckPage> {
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
          MaterialPageRoute(builder: (context) => CheckPage()),
        );
        break;
      case 2:
        // Navigate to ProfileScreen()
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = context.watch<PageState>().currentIndex;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pedido realizado com sucesso!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: tdBlack,
              ),
            ),
            CheckGif(),
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
