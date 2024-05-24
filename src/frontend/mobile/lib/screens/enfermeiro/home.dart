import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/widgets/custom_app_bar.dart';
import '/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/screens/enfermeiro/request_page.dart';
import 'package:PharmaControl/widgets/enfermeiro/my_requests_card.dart';
import 'page_state.dart'; 


class Home extends StatefulWidget {
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
          MaterialPageRoute(builder: (context) => Home()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RequestPage()),
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
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
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
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RequestPage()),
                );
              },
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
            const SizedBox(height: 16.0),
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
