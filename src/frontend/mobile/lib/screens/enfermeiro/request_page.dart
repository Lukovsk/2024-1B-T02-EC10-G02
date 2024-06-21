import 'package:PharmaControl/models/order.dart';
import 'package:PharmaControl/screens/enfermeiro/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:PharmaControl/screens/enfermeiro/revision_page.dart';
import 'package:PharmaControl/widgets/bottom_navigation_bar.dart';
import 'package:PharmaControl/widgets/enfermeiro/text_field.dart';
import 'package:PharmaControl/screens/enfermeiro/home.dart';
import 'package:PharmaControl/models/page_state.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/api/order.dart' as api_order;

import '../../models/item.dart';
import '../../models/pyxis.dart';

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

  Pyxis? _selectedPyxi;

  String? _problem;

  Item? _selectedItem;

  bool _inAsyncCall = false;

  void _asyncCall() async {
    setState(() {
      _inAsyncCall = !_inAsyncCall;
    });
  }

  void fetchPyxis() async {
    _asyncCall();
    List<Pyxis>? data = await api_order.getPyxis();
    if (data != null) {
      setState(() {
        allPyxis = data;
        _inAsyncCall = !_inAsyncCall;
      });
    } else {
      _asyncCall();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha em buscar os pyxis!'),
        ),
      );
    }
  }

  void _updateThirdInputLabel(String selectedProblem) {
    setState(() {
      if (selectedProblem == "Medicamento acabou") {
        thirdInputLabel = "Qual medicamento está em falta?";
        thirdInputOptions = (_selectedPyxi!.items!)
            .where((item) => item.isMedication!)
            .map((item) => item.name)
            .toList();

        _problem = "stock";
        isStockProblem = true;
      } else if (selectedProblem == "Material em falta") {
        thirdInputLabel = "Qual material está em falta?";
        thirdInputOptions = (_selectedPyxi!.items!)
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selecione um problema!'),
          ),
        );
      }
    });
  }

  void _submitRequest() async {
    try {
      if (_problem != null && _selectedPyxi != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NovaSolicitacao(
              problema: _problem!,
              pyxis: _selectedPyxi!,
              item: _selectedItem,
              description: descriptionController.text,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Há algo de errado com o pedido!'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Há algo de errado com o pedido!'),
        ),
      );
    }
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
      body: ModalProgressHUD(
        inAsyncCall: _inAsyncCall,
        child: SingleChildScrollView(
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
      ),
    );
  }

  void _updateItemField(String selection) {
    return setState(() {
      mainController.text = selection;
      _selectedItem =
          _selectedPyxi!.items?.where((item) => item.name == selection).first;
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
