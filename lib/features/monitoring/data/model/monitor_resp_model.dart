import 'package:aquanotes/features/monitoring/data/model/kolam_list.dart';
import 'package:equatable/equatable.dart';

class MonitorRespModel extends Equatable {
  final List<KolamList> kolamList;
  final int currentDeviceId;
  final int currenKolamId;

  const MonitorRespModel(
      this.kolamList, this.currentDeviceId, this.currenKolamId);

  factory MonitorRespModel.fromJson(Map<String, dynamic> json) {
    return MonitorRespModel(
        (json['kolam_list'] as List).map((e) => KolamList.fromJson(e)).toList(),
        json["current_device_id"],
        json["current_kolam_id"]);
  }

  @override
  List<Object?> get props => [kolamList, currenKolamId, currentDeviceId];
}
