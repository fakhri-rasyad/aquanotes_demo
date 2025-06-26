import 'package:aquanotes/features/monitoring/data/model/device.dart';
import 'package:equatable/equatable.dart';

class KolamList extends Equatable {
  final int id;
  final String nama;
  final List<Device> devices;

  const KolamList(this.id, this.nama, this.devices);

  factory KolamList.fromJson(Map<String, dynamic> json) {
    return KolamList(json['id'], json['nama'],
        (json['devices'] as List).map((e) => Device.fromJson(e)).toList());
  }

  @override
  List<Object?> get props => [id, nama, devices];
}
