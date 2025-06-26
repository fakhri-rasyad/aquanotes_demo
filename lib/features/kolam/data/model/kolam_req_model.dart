class KolamReqModel {
  String nama;
  String tipe;
  int panjang;
  int lebar;
  int kedalaman;
  String komoditas;
  int tambakId;
  int deviceId;

  KolamReqModel(this.nama, this.tipe, this.panjang, this.lebar, this.kedalaman,
      this.komoditas, this.tambakId, this.deviceId);

  Map<String, dynamic> toJson() {
    return {
      "nama": nama,
      "tipe": tipe,
      "panjang": panjang,
      "lebar": lebar,
      "kedalaman": kedalaman,
      "komoditas": komoditas,
      "tambak_id": tambakId,
      "device_id": deviceId
    };
  }
}
