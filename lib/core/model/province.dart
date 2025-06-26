import 'package:aquanotes/core/model/regency.dart';
import 'package:aquanotes/features/tambak/domain/entities/province.dart';
import 'package:hive/hive.dart';

part 'province.g.dart';

@HiveType(typeId: 0)
class ProvinceModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String altName;
  @HiveField(3)
  final double latitude;
  @HiveField(4)
  final double longitude;
  @HiveField(5)
  final List<RegencyModel> regencies;

  ProvinceModel(
      {required this.id,
      required this.name,
      required this.altName,
      required this.latitude,
      required this.longitude,
      required this.regencies});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
        id: json["id"],
        name: json["name"],
        altName: json["alt_name"],
        latitude: (json["latitude"] as num?)?.toDouble() ?? 0.0,
        longitude: (json["longitude"] as num?)?.toDouble() ?? 0.0,
        regencies: (json["regencies"] as List)
            .map((e) => RegencyModel.fromJson(e))
            .toList());
  }

  Province toEntity() => Province(
      id: id,
      name: name,
      altName: altName,
      latitude: latitude,
      longitude: longitude,
      regencies: regencies.map((r) => r.toEntity()).toList());
}
