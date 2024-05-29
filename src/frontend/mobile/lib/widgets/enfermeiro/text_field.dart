import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

class AutoCompleteTextFieldWidget extends StatefulWidget {
  final List<String> suggestions;
  final String labelText; // Adicionando labelText como parâmetro

  AutoCompleteTextFieldWidget({
    required this.suggestions,
    required this.labelText, // Definindo labelText como obrigatório
  });

  @override
  _AutoCompleteTextFieldWidgetState createState() =>
      _AutoCompleteTextFieldWidgetState();
}

class _AutoCompleteTextFieldWidgetState
    extends State<AutoCompleteTextFieldWidget> {
  List<String> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  SimpleAutoCompleteTextField? textField;

  @override
  void initState() {
    super.initState();
    textField = SimpleAutoCompleteTextField(
      key: key,
      decoration: InputDecoration(
        labelText: widget.labelText, // Usando o labelText fornecido como parâmetro
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      controller: TextEditingController(text: ""),
      suggestions: widget.suggestions,
      textChanged: (text) => currentText = text,
      clearOnSubmit: true,
      textSubmitted: (text) => setState(() {
        if (text.isNotEmpty) {
          added.add(text);
          currentText = text;
          textField!.updateDecoration(
            decoration: InputDecoration(
              labelText: text,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: textField,
        ),
      ],
    );
  }
}
