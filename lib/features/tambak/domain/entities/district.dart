// "id": "1101010",
// "regency_id": "1101",
// "name": "TEUPAH SELATAN",
// "alt_name": "South Teupah, Simeulue Regency, Aceh, Indonesia",
// "latitude": 2.38603,
// "longitude": 96.42904,
// "villages": [

import 'package:aquanotes/features/tambak/domain/entities/village.dart';

class District {
  final String id;
  final String regencyId;
  final String name;
  final String altName;
  final double latitude;
  final double longitude;
  final List<Village> village;

  District(
      {required this.id,
      required this.regencyId,
      required this.name,
      required this.altName,
      required this.latitude,
      required this.longitude,
      required this.village});
}
