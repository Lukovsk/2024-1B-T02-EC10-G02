
class MedicineModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String area;
  final String quantity;
  final String category;
  final String location;

  MedicineModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.area,
    required this.quantity,
    required this.category,
    required this.location
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      area: json['price'],
      quantity: json['quantity'],
      category: json['category'],
      location: json['location']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': area,
      'quantity': quantity,
      'category': category,
      'location': location
    };
  }

  
}