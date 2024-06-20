class Order {
  String id;
  String? status;
  String? problem;
  String? description;
  Pyxis? pyxis;
  Item? item;
  String? senderId;
  String? receiverId;
  String? createdAt;
  bool? canceled;
  int? rating;
  Order({
    required this.id,
    this.status,
    this.problem,
    this.description,
    this.pyxis,
    this.item,
    this.senderId,
    this.receiverId,
    this.createdAt,
    this.canceled,
    this.rating,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"] as String,
      status: json["status"],
      problem: json["problem"] == "STOCK" ? "estoque" : "técnico",
      description: json["description"],
      pyxis: Pyxis.fromJson(json["pyxis"]),
      item: json["item"] != null ? Item.fromJson(json["item"]) : null,
      senderId: json["sender_userId"],
      receiverId: json["receiver_userId"],
      createdAt: json["createdAt"].split('T')[0],
      canceled: json["canceled"] as bool,
      rating: 0,
    );
  }

  // static Order getExample() {
  //   return Order(
  //     id: "1",
  //     pyxis: 12,
  //     aditionalInfo: {
  //       "ID medicamento": "123456",
  //       "Quantidade": "20",
  //       "Ponto de referência": "Ala-pediátrica",
  //       "InfoX": "XXXX",
  //       "InfoY": "YYYY"
  //     },
  //   );
  // }

  // static List<Order> getExamples() {
  //   return [
  //     Order(
  //       id: "1",
  //       medicine: "Dipirona",
  //       pyxis: 12,
  //       canceled: false,
  //       createdAt: DateTime.now().toString().split(' ')[0],
  //       rating: 4,
  //       sector: "B",
  //       status: true,
  //     ),
  //     Order(
  //       id: "2",
  //       medicine: "Paracetamol",
  //       pyxis: 8,
  //       canceled: false,
  //       createdAt: DateTime.now().toString().split(' ')[0],
  //       rating: 5,
  //       sector: "A",
  //       status: true,
  //     ),
  //     Order(
  //       id: "3",
  //       medicine: "Ibuprofeno",
  //       pyxis: 5,
  //       canceled: true,
  //       createdAt: DateTime.now().toString().split(' ')[0],
  //       rating: 3,
  //       sector: "C",
  //       status: false,
  //     ),
  //     Order(
  //       id: "4",
  //       medicine: "Omeprazol",
  //       pyxis: 10,
  //       canceled: false,
  //       createdAt: DateTime.now().toString().split(' ')[0],
  //       rating: 4,
  //       sector: "B",
  //       status: true,
  //     ),
  //     Order(
  //       id: "5",
  //       medicine: "Amoxicilina",
  //       pyxis: 7,
  //       canceled: false,
  //       createdAt: DateTime.now().toString().split(' ')[0],
  //       rating: 5,
  //       sector: "D",
  //       status: true,
  //     ),
  //   ];
  // }
}

class Pyxis {
  String id;
  String name;
  String? reference;
  String? sector;
  String? ala;
  String? floor;
  List<Item>? items;

  Pyxis({
    required this.id,
    required this.name,
    this.reference,
    this.sector,
    this.ala,
    this.floor,
    this.items,
  });

  factory Pyxis.fromJson(Map<String, dynamic> json) {
    return Pyxis(
      id: json["id"] as String,
      name: json["name"],
      reference: json["reference"],
      sector: json["sector"],
      ala: json["ala"],
      floor: json["floor"],
    );
  }

  factory Pyxis.fromJsonWithItems(Map<String, dynamic> json) {
    return Pyxis(
      id: json["id"] as String,
      name: json["name"],
      reference: json["reference"],
      sector: json["sector"],
      ala: json["ala"],
      floor: json["floor"],
      items: json["items"].map((d) => Item.fromJson(d)).toList(),
    );
  }
}

class Item {
  String id;
  String name;
  bool? isMedication;
  String? area;
  String? description;
  String? lot;
  String? medClass;

  Item({
    required this.id,
    required this.name,
    this.isMedication,
    this.area,
    this.description,
    this.lot,
    this.medClass,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"] as String,
      name: json["name"],
      isMedication: json["isMedication"],
      area: json["area"],
      description: json["description"],
      lot: json["lot"],
      medClass: json["medClass"],
    );
  }

  static Item getExample() {
    return Item(
      id: "1",
      name: "Dipirona",
      isMedication: true,
      area: "Todas",
      description: "pra dor de cabeça",
      lot: "123456",
      medClass: "MED",
    );
  }
}
