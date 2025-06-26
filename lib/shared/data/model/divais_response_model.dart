class DivaisResponseModel {
  final int id;
  final String uid;
  final String name;

  DivaisResponseModel(this.id, this.name, this.uid);

  factory DivaisResponseModel.fromJson(Map<String, dynamic> json) {
    return DivaisResponseModel(json["id"], json["name"], json["uid"]);
  }

  Map<String, dynamic> toJson() => {"name": name, "uid": uid};
}
