import 'package:aquanotes/features/monitoring/data/model/device_data.dart';
import 'package:equatable/equatable.dart';

class Device extends Equatable {
  final int id;
  final String name;
  final DeviceData latestData;
  final List<DeviceData> historicalData;

  const Device(this.id, this.name, this.latestData, this.historicalData);

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
        json['id'],
        json['name'],
        DeviceData.fromJson(json['latest_data']),
        (json['historical_data'] as List)
            .map((e) => DeviceData.fromJson(e))
            .toList());
  }

  @override
  List<Object?> get props => [id, name, latestData, historicalData];
}
