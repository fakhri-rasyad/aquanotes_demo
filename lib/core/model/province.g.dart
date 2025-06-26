// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProvinceModelAdapter extends TypeAdapter<ProvinceModel> {
  @override
  final int typeId = 0;

  @override
  ProvinceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProvinceModel(
      id: fields[0] as String,
      name: fields[1] as String,
      altName: fields[2] as String,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
      regencies: (fields[5] as List).cast<RegencyModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProvinceModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.altName)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.regencies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvinceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
