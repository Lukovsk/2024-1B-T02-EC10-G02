class User {
  String? id;
  bool? disponibility;
  String? name;
  String? email;
  String? role;

  User({
    required this.id,
    required this.disponibility,
    required this.name,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      disponibility: json["disponibility"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
    );
  }
}
