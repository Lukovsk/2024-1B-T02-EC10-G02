import 'item.dart';
import 'pyxis.dart';

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
