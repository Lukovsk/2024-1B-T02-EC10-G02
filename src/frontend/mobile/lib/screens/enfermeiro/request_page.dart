import 'package:PharmaControl/screens/enfermeiro/check_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PharmaControl/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/screens/enfermeiro/home.dart';
import 'package:PharmaControl/screens/enfermeiro/page_state.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:PharmaControl/widgets/enfermeiro/text_field.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
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
    List<String> problem = [
      "Medicamento acabou",
      "Material em falta",
      "Problemas técnicos com o pyxis",
    ];

    int _currentIndex = context.watch<PageState>().currentIndex;
    String selectedOption = '';
    TextEditingController customOptionController = TextEditingController();

    List<String> options = ['Opção 1', 'Opção 2', 'Opção 3'];
    List<String> pyxisOptions = [
      'Pyxis 1',
      'Pyxis 2',
      'Pyxis 3',
    ];

    List<String> materialOptions = [
      'Gaze',
      'Luva',
      'Máscara',
      'Seringa',
      'Agulha',
      'Avental',
      'Touca',
      'Álcool em gel',
      'Fita adesiva',
      'Esparadrapo',
      'Soro fisiológico',
    ];
    
    List<String> added = [];
    String currentText = "";
    GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Nova solicitação',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF2563AF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Preencha as informações',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: tdBlack,
              ),
            ),
            SizedBox(height: 16.0),
            AutoCompleteTextFieldWidget(
                suggestions: problem, labelText: 'Qual o seu problema?'),
            SizedBox(height: 16.0),
            AutoCompleteTextFieldWidget(
                suggestions: pyxisOptions, labelText: 'Qual o pyxis?'),
            SizedBox(height: 16.0),
            AutoCompleteTextFieldWidget(
                suggestions: materialOptions, labelText: 'Qual o material?'),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Alguma observação?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CheckPage()),
                  );
                
                },
                child: Text(
                  'Enviar solicitação',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2563AF),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 12.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
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
