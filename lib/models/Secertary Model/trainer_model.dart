class Trainer {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? specialty;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Trainer({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.specialty,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      specialty: json['specialty'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'specialty': specialty,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
