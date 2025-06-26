class TambakResponseModel {
  final int id;
  final String name;
  final String cultivationType;

  TambakResponseModel(
    this.id,
    this.name,
    this.cultivationType,
  );

  factory TambakResponseModel.fromJson(Map<String, dynamic> json) {
    return TambakResponseModel(json["id"] as int, json["name"] as String,
        json["cultivation_type"] as String);
  }
}
