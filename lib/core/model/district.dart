import 'package:aquanotes/core/model/village.dart';
import 'package:aquanotes/features/tambak/domain/entities/district.dart';
import 'package:hive/hive.dart';

part 'district.g.dart';

@HiveType(typeId: 2)
class DistrictModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String regencyId;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String altName;
  @HiveField(4)
  final double latitude;
  @HiveField(5)
  final double longitude;
  @HiveField(6)
  final List<VillageModel> villages;

  DistrictModel(
      {required this.id,
      required this.regencyId,
      required this.name,
      required this.altName,
      required this.villages,
      required this.latitude,
      required this.longitude});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
        id: json["id"],
        regencyId: json["regency_id"],
        name: json["name"],
        altName: json["alt_name"],
        latitude: (json["latitude"] as num?)?.toDouble() ?? 0.0,
        longitude: (json["longitude"] as num?)?.toDouble() ?? 0.0,
        villages: (json["villages"] as List)
            .map((e) => VillageModel.fromJson(e))
            .toList());
  }

  District toEntity() => District(
      id: id,
      regencyId: regencyId,
      name: name,
      altName: altName,
      latitude: latitude,
      longitude: longitude,
      village: villages.map((r) => r.toEntity()).toList());
}
