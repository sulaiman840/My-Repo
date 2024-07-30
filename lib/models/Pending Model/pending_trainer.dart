class PendingTrainer {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String specialty;
  final String description;
  final String status;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  PendingTrainer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.specialty,
    required this.description,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PendingTrainer.fromJson(Map<String, dynamic> json) {
    return PendingTrainer(
      id: json['id'],
      name: json['requsetPending']['name'],
      email: json['requsetPending']['email'],
      phone: json['requsetPending']['phone'],
      address: json['requsetPending']['address'],
      specialty: json['requsetPending']['specialty'],
      description: json['requsetPending']['description'],
      status: json['status'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
