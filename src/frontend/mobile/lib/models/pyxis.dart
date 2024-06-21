import 'package:PharmaControl/models/item.dart';

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
      items: (json["items"] as List).isNotEmpty
          ? (json["items"] as List).map((d) => Item.fromJson(d)).toList()
          : null,
    );
  }
}
