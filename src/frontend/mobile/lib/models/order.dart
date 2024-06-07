class Order {
  String id;
  int? pyxis;
  String? sector;
  bool? status;
  int? rating;
  bool? canceled;
  String? createdAt;
  Map<String, String>? aditionalInfo;
  String? medicine;

  Order({
    required this.id,
    this.pyxis,
    this.canceled,
    this.createdAt,
    this.rating,
    this.sector,
    this.status,
    this.aditionalInfo,
    this.medicine,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"] as String,
      medicine: json["title"] as String,
      pyxis: 12,
      canceled: json["canceled"] as bool,
      createdAt: json["createdAt"].split('T')[0],
      rating: json["rating"] as int,
      sector: json["sector"] as String,
      status: json["status"] as bool,
    );
  }

  static Order getExample() {
    return Order(
      id: "1",
      pyxis: 12,
      aditionalInfo: {
        "ID medicamento": "123456",
        "Quantidade": "20",
        "Ponto de referência": "Ala-pediátrica",
        "InfoX": "XXXX",
        "InfoY": "YYYY"
      },
    );
  }

  static List<Order> getExamples() {
    return [
      Order(
        id: "1",
        medicine: "Dipirona",
        pyxis: 12,
        canceled: false,
        createdAt: DateTime.now().toString().split(' ')[0],
        rating: 4,
        sector: "B",
        status: true,
      ),
      Order(
        id: "2",
        medicine: "Paracetamol",
        pyxis: 8,
        canceled: false,
        createdAt: DateTime.now().toString().split(' ')[0],
        rating: 5,
        sector: "A",
        status: true,
      ),
      Order(
        id: "3",
        medicine: "Ibuprofeno",
        pyxis: 5,
        canceled: true,
        createdAt: DateTime.now().toString().split(' ')[0],
        rating: 3,
        sector: "C",
        status: false,
      ),
      Order(
        id: "4",
        medicine: "Omeprazol",
        pyxis: 10,
        canceled: false,
        createdAt: DateTime.now().toString().split(' ')[0],
        rating: 4,
        sector: "B",
        status: true,
      ),
      Order(
        id: "5",
        medicine: "Amoxicilina",
        pyxis: 7,
        canceled: false,
        createdAt: DateTime.now().toString().split(' ')[0],
        rating: 5,
        sector: "D",
        status: true,
      ),
    ];
  }
}
