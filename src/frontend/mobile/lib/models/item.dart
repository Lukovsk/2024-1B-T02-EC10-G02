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
