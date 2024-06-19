import 'package:PharmaControl/constants/colors.dart';
import 'package:PharmaControl/models/order.dart';
import 'package:PharmaControl/screens/auxiliar/home.dart';
import 'package:PharmaControl/screens/enfermeiro/check_page.dart';
import 'package:PharmaControl/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  final Order order;

  const OrderDetail({super.key, required this.order});

  @override
  State<OrderDetail> createState() => _OrderState();
}

class _OrderState extends State<OrderDetail> {
  @override
  void initState() {
    super.initState();
  }

  // TODO: integrando, deve abrir um modal para demonstrar a razão do cancelamento
  void _cancelOnTap() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuxHome()),
    );
  }

  // TODO: integrando, o modal deve enviar um novo pedido à fila com o status de cancelamento e a razão do cancelamento no payload

  // TODO: integrando, deve enviar o pedido à fila com o status de finalizado e abrir um modal para fornecer o feedback
  void _concludeOnTap() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CheckPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Container(
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
                const Divider(
                  color: hsNiceBlueColor,
                  thickness: 6,
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
                boxShadow: [
                  const BoxShadow(
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
                      "Atendimento: Pyxispyxis - ${widget.order.pyxis}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
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
                        PointsInfo(pointTo: widget.order.pyxis ?? 1)
                      ],
                    ),
                  ),
                  // * Info adicional
                  AditionalInfo(info: widget.order.aditionalInfo ?? {}),

                  // * Botões
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: _concludeOnTap,
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(hsNiceBlueColor),
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
    );
  }
}

class AditionalInfo extends StatelessWidget {
  const AditionalInfo({
    super.key,
    required Map<String, String> info,
  });

  // TODO: criar lógica para criar dinamicamente a informação adicional, respeitando o máximo de duas colunas com três linhas cada.

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID medicamento: 1234543",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Quantidade: 20 unidades",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Ponto de referência: Ala-pediátrica",
                    style: TextStyle(
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
                    "InfoX: XXXX",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "InfoY: YYYY",
                    style: TextStyle(
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
  final int pointTo;
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
              Text("Pyxispyxis $pointTo",
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
