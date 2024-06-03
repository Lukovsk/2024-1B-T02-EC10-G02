import 'package:flutter/material.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/screens/enfermeiro/my_requests_page.dart'; 

class MyRequestsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderScreen()),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: tdGradient.colors[1],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: tdRed,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Text(
                      'Atualizações',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Meus Pedidos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Image(
                image: AssetImage('lib/assets/images/medicine.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
