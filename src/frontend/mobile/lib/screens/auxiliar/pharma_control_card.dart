import 'package:flutter/material.dart';

class PharmaControlCard extends StatelessWidget {
  final String title;
  final String idMedicamento;
  final String quantidade;
  final String pontoReferencia;
  final VoidCallback onAccepted;
  final VoidCallback onDeclined;

  PharmaControlCard({
    required this.title,
    required this.idMedicamento,
    required this.quantidade,
    required this.pontoReferencia,
    required this.onAccepted,
    required this.onDeclined,
  });

  void _showConfirmationDialog(BuildContext context, String action) {
    if (action == "Aceitar") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Atendimento: $title',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        child: Text(
                          "1",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 2),
                        color: Colors.blue,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        child: Text(
                          "2",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Ponto 1: Farmácia central'),
                  Text('Ponto 2: $title'),
                  SizedBox(height: 20),
                  Text(
                    'Informações adicionais',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('ID medicamento: $idMedicamento'),
                  Text('Quantidade: $quantidade'),
                  Text('Ponto de referência: $pontoReferencia'),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onAccepted();
                      },
                      child: Text('Finalizar'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (action == "Negar") {
      TextEditingController motivoController = TextEditingController();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Motivo do Cancelamento'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: motivoController,
                  decoration: InputDecoration(
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
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Adicione a lógica para tratar o motivo do cancelamento
                  onDeclined();
                },
                child: Text('Confirmar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.medical_services, size: 50, color: Colors.black54),
                SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ID medicamento: $idMedicamento'),
                Text('Quantidade: $quantidade'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Ponto de referência: $pontoReferencia'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    _showConfirmationDialog(context, "Aceitar");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    fixedSize: MaterialStateProperty.all(Size(120, 0)),
                  ),
                  child: Text(
                    "Aceitar",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _showConfirmationDialog(context, "Negar");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    fixedSize: MaterialStateProperty.all(Size(120, 0)),
                  ),
                  child: Text(
                    "Negar",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
