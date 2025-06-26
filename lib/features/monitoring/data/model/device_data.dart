import 'package:equatable/equatable.dart';

class DeviceData extends Equatable {
  final int suhu;
  final int ph;
  final int dox;
  final int tds;
  final int ammonia;
  final int salinitas;
  final String timestamp;

  const DeviceData(this.suhu, this.ph, this.dox, this.tds, this.ammonia,
      this.salinitas, this.timestamp);

  factory DeviceData.fromJson(Map<String, dynamic> json) {
    return DeviceData(json['suhu'], json['ph'], json['do'], json['tds'],
        json['ammonia'], json['salinitas'], json['timestamp']);
  }

  @override
  List<Object?> get props =>
      [suhu, ph, dox, tds, ammonia, salinitas, timestamp];
}

// {
//               "suhu": 0,
//               "ph": 0,
//               "do": 0,
//               "tds": 0,
//               "ammonia": 0,
//               "salinitas": 0,
//               "timestamp": "2025-06-14T01:25:54.919Z"
//             }
