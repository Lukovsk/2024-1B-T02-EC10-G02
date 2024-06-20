import 'package:PharmaControl/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PharmaControl/screens/enfermeiro/revision_page.dart';
import 'package:PharmaControl/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/widgets/enfermeiro/text_field.dart';
import 'package:PharmaControl/screens/enfermeiro/home.dart';
import 'package:PharmaControl/screens/enfermeiro/page_state.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/api/order.dart' as api_order;

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  TextEditingController problemController = TextEditingController();
  TextEditingController pyxisController = TextEditingController();
  TextEditingController mainController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String thirdInputLabel = 'Qual o material?';
  List<String> thirdInputOptions = [];
  bool isStockProblem = false;
  List<Pyxis> allPyxis = [];

  late Pyxis _selectedPyxi;

  late String _problem;

  late Item? _selectedItem;

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
          MaterialPageRoute(builder: (context) => const RequestPage()),
        );
        break;
      case 2:
        // Navigate to ProfileScreen()
        break;
      default:
        break;
    }
  }

  void fetchPyxis() async {
    List<Pyxis>? data = await api_order.getPyxis();
    if (data != null) {
      setState(() {
        allPyxis = data;
      });
    } else {}
  }

  void _updateThirdInputLabel(String selectedProblem) {
    setState(() {
      if (selectedProblem == "Medicamento acabou") {
        thirdInputLabel = "Qual medicamento está em falta?";
        thirdInputOptions = (_selectedPyxi.items!)
            .where((item) => item.isMedication!)
            .map((item) => item.name)
            .toList();

        _problem = "stock";
        isStockProblem = true;
      } else if (selectedProblem == "Material em falta") {
        thirdInputLabel = "Qual material está em falta?";
        thirdInputOptions = (_selectedPyxi.items!)
            .where((item) => !item.isMedication!)
            .map((item) => item.name)
            .toList();

        _problem = "stock";
        isStockProblem = true;
      } else if (selectedProblem == "Problemas técnicos com o pyxis") {
        isStockProblem = false;
        _selectedItem = null;
        thirdInputLabel = "Problemas técnicos com o pyxis";
        _problem = "technical";
      }
    });
  }

  void _submitRequest() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NovaSolicitacao(
          problema: _problem,
          pyxis: _selectedPyxi,
          item: _selectedItem,
          description: descriptionController.text,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchPyxis();
  }

  @override
  Widget build(BuildContext context) {
    List<String> problemOptions = [
      "Medicamento acabou",
      "Material em falta",
      "Problemas técnicos com o pyxis",
    ];

    int currentIndex = context.watch<PageState>().currentIndex;

    List<String> pyxisOptions = allPyxis.map((item) => item.name).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Nova solicitação',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2563AF),
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
              const SizedBox(height: 16.0),
              AutoCompleteTextFieldWidget(
                suggestions: pyxisOptions,
                labelText: 'Qual o pyxis?',
                controller: pyxisController,
                onSelected: (selection) => _updatePyxisField(selection),
              ),
              const SizedBox(height: 16.0),
              AutoCompleteTextFieldWidget(
                suggestions: problemOptions,
                labelText: 'Qual o seu problema?',
                controller: problemController,
                onSelected: (selection) => _updateProblemField(selection),
              ),
              const SizedBox(height: 16.0),
              if (isStockProblem)
                AutoCompleteTextFieldWidget(
                  suggestions: thirdInputOptions,
                  labelText: thirdInputLabel,
                  controller: mainController,
                  onSelected: (selection) => _updateItemField(selection),
                ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  maxLines: 4,
                  controller: descriptionController,
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
                  onPressed: _submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563AF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Revisar solicitação',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
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

  void _updateItemField(String selection) {
    return setState(() {
      mainController.text = selection;
      _selectedItem =
          _selectedPyxi.items?.where((item) => item.name == selection).first;
    });
  }

  void _updateProblemField(String selection) {
    return setState(() {
      problemController.text = selection;
      _updateThirdInputLabel(selection);
    });
  }

  void _updatePyxisField(String selection) {
    return setState(() {
      pyxisController.text = selection;
      _selectedPyxi = allPyxis.where((item) => item.name == selection).first;
    });
  }
}
