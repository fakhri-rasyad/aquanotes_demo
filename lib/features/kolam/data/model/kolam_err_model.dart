class KolamErrModel {
  String msg;
  String type;

  KolamErrModel(this.msg, this.type);

  factory KolamErrModel.fromJson(Map<String, dynamic> json) {
    final responseArray = json["detail"][0];
    return KolamErrModel(
        responseArray["msg"] as String, responseArray["type"] as String);
  }
}
// {
//   "detail": [
//     {
//       "loc": [
//         "string",
//         0
//       ],
//       "msg": "string",
//       "type": "string"
//     }
//   ]
// }
