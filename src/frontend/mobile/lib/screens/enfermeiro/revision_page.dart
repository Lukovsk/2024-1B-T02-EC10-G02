import 'package:PharmaControl/models/order.dart';
import 'package:flutter/material.dart';
import 'package:PharmaControl/screens/enfermeiro/check_page.dart';
import 'package:PharmaControl/screens/enfermeiro/request_page.dart';
import 'package:PharmaControl/widgets/custom_app_bar.dart';
import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/api/order.dart' as api_order;
import 'package:PharmaControl/globals.dart' as globals;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../models/item.dart';
import '../../models/pyxis.dart';

class NovaSolicitacao extends StatefulWidget {
  final String problema;
  final Pyxis pyxis;
  final Item? item;
  final String? description;

  const NovaSolicitacao({
    super.key,
    required this.problema,
    required this.pyxis,
    required this.item,
    required this.description,
  });

  @override
  State<NovaSolicitacao> createState() => _NovaSolicitacaoState();
}

class _NovaSolicitacaoState extends State<NovaSolicitacao> {
  bool _inAsyncCall = false;

  void _asyncCall() async {
    setState(() {
      _inAsyncCall = !_inAsyncCall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ModalProgressHUD(
        inAsyncCall: _inAsyncCall,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Revise o seu pedido',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: hsBlackColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const Text(
                'Qual o seu problema?',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                widget.problema,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              const Text(
                'Qual o pyxis?',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                widget.pyxis.name,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              if (widget.description != null)
                Text(
                  widget.description!,
                  style: const TextStyle(fontSize: 18),
                ),
              if (widget.item != null)
                Text(
                  widget.item!.name,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => _createOrder(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF0D47A1),
                ),
                child: const Text('Fazer pedido'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Alterar pedido',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createOrder(context) async {
    _asyncCall();
    if (await api_order.createOrder(globals.user!.id!, widget.pyxis.id,
        widget.problema, widget.description, widget.item?.id)) {
      _asyncCall();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CheckPage()),
      );
    } else {
      _asyncCall();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha em fazer pedido!'),
        ),
      );
    }
  }
}
