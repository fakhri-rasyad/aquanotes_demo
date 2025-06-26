import 'package:aquanotes/features/tambak/domain/entities/village.dart';
import 'package:hive/hive.dart';

part 'village.g.dart';

@HiveType(typeId: 3)
class VillageModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String districtId;
  @HiveField(2)
  final String name;

  VillageModel(this.districtId, this.id, this.name);

  factory VillageModel.fromJson(Map<String, dynamic> json) {
    return VillageModel(json["district_id"], json["id"], json["name"]);
  }

  Village toEntity() => Village(id: id, districtId: districtId, name: name);
}
