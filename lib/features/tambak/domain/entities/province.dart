import 'package:aquanotes/features/tambak/domain/entities/regency.dart';

class Province {
  final String id;
  final String name;
  final String altName;
  final double latitude;
  final double longitude;
  final List<Regency> regencies;

  Province(
      {required this.id,
      required this.name,
      required this.altName,
      required this.latitude,
      required this.longitude,
      required this.regencies});
}
