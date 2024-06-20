import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:PharmaControl/screens/enfermeiro/revision_page.dart';
import 'package:PharmaControl/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/widgets/enfermeiro/text_field.dart';
import 'package:PharmaControl/screens/enfermeiro/home.dart';
import 'package:PharmaControl/screens/enfermeiro/page_state.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/screens/enfermeiro/order_state.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  TextEditingController problemController = TextEditingController();
  TextEditingController pyxisController = TextEditingController();
  TextEditingController materialController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController mainController = TextEditingController();

  String thirdInputLabel = 'Qual o material?';
  List<String> thirdInputOptions = [];
  bool showThirdInput = true;

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

  void _updateThirdInputLabel(String selectedProblem) {
    setState(() {
      if (selectedProblem == "Medicamento acabou") {
        thirdInputLabel = "Qual medicamento está em falta?";
        thirdInputOptions = [
          'Dipirona',
          'Paracetamol',
          'Ibuprofeno',
          'Dorflex',
          'Buscopan',
          'Omeprazol',
          'Dexametasona',
          'Prednisona',
          'Amoxicilina',
          'Azitromicina',
        ];
        mainController = medicineController;
        showThirdInput = true;
      } else if (selectedProblem == "Material em falta") {
        thirdInputLabel = "Qual material está em falta?";
        thirdInputOptions = [
          'Esparadrapo',
          'Gaze',
          'Luva',
          'Máscara',
          'Seringa',
          'Agulha',
          'Avental',
          'Touca',
          'Álcool em gel',
          'Fita adesiva',
          'Soro fisiológico',
        ];
        mainController = materialController;
        showThirdInput = true;
      } else if (selectedProblem == "Problemas técnicos com o pyxis") {
        showThirdInput = false;
        thirdInputLabel = "Problemas técnicos com o pyxis";
        pyxisController.text = "Pyxis 1";
      } else {
        thirdInputLabel = "Qual o material?";
        thirdInputOptions = [];
        showThirdInput = true;
      }
    });
  }

  Future<void> _submitRequest() async {
  final order = Order(
    id: 'unique_order_id',  // Você pode gerar um ID único aqui
    problema: problemController.text,
    pyxis: pyxisController.text,
    material: mainController.text,
    status: 'new',
    date: DateTime.now().toIso8601String(),
    rating: 0,
    avaliacaoPreenchida: false,
    aditionalInfo: '', 
  );

  context.read<Order>();

  final url = Uri.parse('http://50.19.149.200:3001/order/');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(order.toJson()),
  );

  if (response.statusCode == 200) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NovaSolicitacao(
          problema: problemController.text,
          pyxis: pyxisController.text,
          material: mainController.text,
          problemSelected: problemController.text,
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Falha ao enviar solicitação')),
    );
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

    List<String> pyxisOptions = [
      'Pyxis 1',
      'Pyxis 2',
      'Pyxis 3',
    ];

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const Text(
                'Preencha as informações',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: hsBlackColor,
                ),
              ),
              SizedBox(height: 16.0),
              AutoCompleteTextFieldWidget(
                suggestions: problem,
                labelText: 'Qual o seu problema?',
                controller: problemController,
                onSelected: (selection) {
                  setState(() {
                    problemController.text = selection;
                    _updateThirdInputLabel(selection);
                  });
                },
              ),
              SizedBox(height: 16.0),
              AutoCompleteTextFieldWidget(
                suggestions: pyxisOptions,
                labelText: 'Qual o pyxis?',
                controller: pyxisController,
                onSelected: (selection) {
                  setState(() {
                    pyxisController.text = selection;
                  });
                },
              ),
              SizedBox(height: 16.0),
              if (showThirdInput)
                AutoCompleteTextFieldWidget(
                  suggestions: thirdInputOptions,
                  labelText: thirdInputLabel,
                  controller: mainController,
                  onSelected: (selection) {
                    setState(() {
                      mainController.text = selection;
                    });
                  },
                ),
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
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _submitRequest();
                  },
                  child: Text(
                    'Revisar solicitação',
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
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
