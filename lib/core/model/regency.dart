import 'package:aquanotes/core/model/district.dart';
import 'package:aquanotes/features/tambak/domain/entities/regency.dart';
import 'package:hive/hive.dart';

part 'regency.g.dart';

@HiveType(typeId: 1)
class RegencyModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String provinceId;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String altName;
  @HiveField(4)
  final double latitude;
  @HiveField(5)
  final double longitude;
  @HiveField(6)
  final List<DistrictModel> districts;

  RegencyModel(
      {required this.id,
      required this.provinceId,
      required this.name,
      required this.altName,
      required this.latitude,
      required this.longitude,
      required this.districts});

  factory RegencyModel.fromJson(Map<String, dynamic> json) {
    return RegencyModel(
        id: json["id"],
        provinceId: json["province_id"],
        name: json["name"],
        altName: json["alt_name"],
        latitude: (json["latitude"] as num?)?.toDouble() ?? 0.0,
        longitude: (json["longitude"] as num?)?.toDouble() ?? 0.0,
        districts: (json["districts"] as List)
            .map((e) => DistrictModel.fromJson(e))
            .toList());
  }

  Regency toEntity() => Regency(
      id: id,
      provinceId: provinceId,
      name: name,
      altName: altName,
      latitude: latitude,
      longitude: longitude,
      districts: districts.map((r) => r.toEntity()).toList());
}
