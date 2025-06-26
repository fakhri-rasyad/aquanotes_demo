class RegistResponseModel {
  final int id;
  final String name;
  final String email;

  RegistResponseModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory RegistResponseModel.fromJson(Map<String, dynamic> json) {
    return RegistResponseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}
