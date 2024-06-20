class Order {
  final String id;
  final String problema;
  final String pyxis;
  final String material;
  final String status;
  final String date;
  final int rating;
  bool avaliacaoPreenchida;
  final String aditionalInfo;

  Order({
    required this.id,
    required this.problema,
    required this.pyxis,
    required this.material,
    required this.status,
    required this.date,
    required this.rating,
    this.avaliacaoPreenchida = false,
    this.aditionalInfo = '',
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"] as String,
      problema: json["problema"],
      pyxis: json["pyxis"],
      material: json["material"],
      status: json["status"],
      date: json["date"],
      rating: json["rating"] as int,
      avaliacaoPreenchida: json["avaliacaoPreenchida"] ?? false,
      aditionalInfo: json["aditionalInfo"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'problema': problema,
      'pyxis': pyxis,
      'material': material,
      'status': status,
      'date': date,
      'rating': rating,
      'avaliacaoPreenchida': avaliacaoPreenchida,
      'aditionalInfo': aditionalInfo,
    };
  }
}
