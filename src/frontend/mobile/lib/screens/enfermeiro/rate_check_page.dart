import 'package:PharmaControl/screens/enfermeiro/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PharmaControl/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/screens/enfermeiro/home.dart';
import 'package:PharmaControl/models/page_state.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:gif_view/gif_view.dart';

class CheckGif extends StatefulWidget {
  const CheckGif({super.key});

  @override
  _CheckGifState createState() => _CheckGifState();
}

class _CheckGifState extends State<CheckGif> {
  @override
  Widget build(BuildContext context) {
    return GifView.asset(
      'lib/assets/videos/check.gif',
      height: 400,
      width: 400,
      frameRate: 30,
    );
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
          MaterialPageRoute(builder: (context) => const NurseOrders()),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Solicitação avaliação com sucesso!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: hsBlackColor,
                ),
              ),
              SizedBox(height: 20), // Espaço entre o texto e o GIF
              CheckGif(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
