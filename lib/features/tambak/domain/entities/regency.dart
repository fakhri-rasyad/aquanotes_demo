// "id": "1101",
//         "province_id": "11",
//         "name": "KABUPATEN SIMEULUE",
//         "alt_name": "KABUPATEN SIMEULUE",
//         "latitude": 2.61667,
//         "longitude": 96.08333,
//         "districts": [

import 'package:aquanotes/features/tambak/domain/entities/district.dart';

class Regency {
  final String id;
  final String provinceId;
  final String name;
  final String altName;
  final double latitude;
  final double longitude;
  final List<District> districts;

  Regency(
      {required this.id,
      required this.provinceId,
      required this.name,
      required this.altName,
      required this.latitude,
      required this.longitude,
      required this.districts});
}
