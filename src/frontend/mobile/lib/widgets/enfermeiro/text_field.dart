import 'package:flutter/material.dart';

class AutoCompleteTextFieldWidget extends StatefulWidget {
  final List<String> suggestions;
  final String labelText;
  final TextEditingController controller;
  final void Function(String) onSelected;

  AutoCompleteTextFieldWidget({
    required this.suggestions,
    required this.labelText,
    required this.controller,
    required this.onSelected,
  });

  @override
  _AutoCompleteTextFieldWidgetState createState() =>
      _AutoCompleteTextFieldWidgetState();
}

class _AutoCompleteTextFieldWidgetState
    extends State<AutoCompleteTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        // if (textEditingValue.text.isEmpty) {
        //   return const Iterable<String>.empty();
        // }
        return widget.suggestions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        widget.controller.text = selection;
        widget.onSelected(selection);
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        fieldTextEditingController.value = widget.controller.value;
        return TextField(
          controller: fieldTextEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: widget.labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        );
      },
    );
  }
}
