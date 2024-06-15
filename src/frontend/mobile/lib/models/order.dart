class Order {
  String id;
  String pyxi;

  Map<String, String> aditionalInfo;

  Order({
    required this.id,
    required this.pyxi,
    required this.aditionalInfo,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      pyxi: json["pyxi"],
      aditionalInfo: json["aditional_info"],
    );
  }

  static Order getExample() {
    return Order(
      id: "orderteste",
      pyxi: "12A",
      aditionalInfo: {
        "ID medicamento": "123456",
        "Quantidade": "20",
        "Ponto de referência": "Ala-pediátrica",
        "InfoX": "XXXX",
        "InfoY": "YYYY"
      },
    );
  }
}
