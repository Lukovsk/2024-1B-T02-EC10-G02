import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/models/order.dart';
import 'package:PharmaControl/screens/auxiliar/home.dart';
import 'package:PharmaControl/widgets/custom_app_bar.dart';
import 'package:PharmaControl/widgets/fancy_container.dart';
import 'package:flutter/material.dart';
import 'package:PharmaControl/api/order.dart' as api_order;
import 'package:PharmaControl/globals.dart' as globals;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OrderDetail extends StatefulWidget {
  final Order order;

  const OrderDetail({super.key, required this.order});

  @override
  State<OrderDetail> createState() => _OrderState();
}

class _OrderState extends State<OrderDetail> {
  bool _inAsyncCall = false;
  @override
  void initState() {
    super.initState();
  }

  void _inAsync() {
    setState(() {
      _inAsyncCall = !_inAsyncCall;
    });
  }

  void _cancelOnTap() {
    TextEditingController motivoController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Motivo do Cancelamento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: motivoController,
                decoration: const InputDecoration(
                  hintText: 'Digite o motivo do cancelamento',
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Adicione a lógica para tratar o motivo do cancelamento
                _cancelOrder(motivoController.text);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _cancelOrder(String reason) async {
    _inAsync();
    if (await api_order.cancelOrder(
        widget.order.id, reason, globals.user!.id!)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuxHome()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha no tentando concluir o pedido!'),
        ),
      );
    }
    _inAsync();
  }

  // TODO: integrando, deve enviar o pedido à fila com o status de finalizado e abrir um modal para fornecer o feedback
  void _concludeOnTap() async {
    _inAsync();
    if (await api_order.doneOrder(widget.order.id)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuxHome()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha no tentando concluir o pedido!'),
        ),
      );
    }
    _inAsync();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: ModalProgressHUD(
        inAsyncCall: _inAsyncCall,
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // header
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Atendimento em andamento",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FancyContainer(
                    size: Size(width, 8),
                    cycle: const Duration(seconds: 2),
                    colors: const <Color>[
                      Colors.cyan,
                      Colors.blue,
                      Colors.cyan,
                      Colors.blue,
                      Colors.cyan,
                    ],
                  ),
                ],
              ),
              // card
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: const Border(
                    top: BorderSide(
                      color: hsGreenColor,
                      width: 30,
                    ),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 20,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // * Título
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Text(
                        "Atendimento: ${widget.order.pyxis?.name} \n Problema: ${widget.order.problem} \n ${widget.order.item?.name ?? ''}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // * From To Container
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const PointsWithLine(),
                          PointsInfo(
                            pointTo: widget.order.pyxis!.name,
                          )
                        ],
                      ),
                    ),
                    // * Info adicional
                    AditionalInfo(order: widget.order),

                    // * Botões
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: _concludeOnTap,
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                hsNiceBlueColor),
                            fixedSize:
                                MaterialStatePropertyAll<Size>(Size(180, 0)),
                          ),
                          child: const Text(
                            "Finalizar",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _cancelOnTap,
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(tdRed),
                            fixedSize:
                                MaterialStatePropertyAll<Size>(Size(100, 0)),
                          ),
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AditionalInfo extends StatelessWidget {
  final Order order;

  const AditionalInfo({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: const Text(
              "Informações adicionais",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Problema: ${order.problem}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    order.problem == "estoque"
                        ? "${order.item?.name}"
                        : "${order.description}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Referência: ${order.pyxis?.reference}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Andar: ${order.pyxis!.floor}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Ala ${order.pyxis!.ala}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Setor ${order.pyxis!.sector}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PointsInfo extends StatelessWidget {
  final String? pointTo;
  const PointsInfo({
    super.key,
    required this.pointTo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Ponto 1: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Farmácia central",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            ],
          ),
          Row(
            children: [
              const Text("Ponto 2: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("$pointTo",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400)),
            ],
          ),
        ],
      ),
    );
  }
}

class PointsWithLine extends StatelessWidget {
  const PointsWithLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //bolinhas
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: hsDarkBlueColor,
          ),
          child: const Text(
            "1",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 80,
            vertical: 2,
          ),
          color: hsDarkBlueColor,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: hsDarkBlueColor,
          ),
          child: const Text(
            "2",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
