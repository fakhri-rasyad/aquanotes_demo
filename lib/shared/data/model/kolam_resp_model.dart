class KolamRespModel {
  int id;
  String nama;
  String komoditas;
  KolamRespModel(this.id, this.komoditas, this.nama);

  factory KolamRespModel.fromJson(Map<String, dynamic> json) {
    return KolamRespModel(
        json["id"] as int, json["komoditas"] as String, json["nama"] as String);
  }
}
