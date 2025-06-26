// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regency.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegencyModelAdapter extends TypeAdapter<RegencyModel> {
  @override
  final int typeId = 1;

  @override
  RegencyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegencyModel(
      id: fields[0] as String,
      provinceId: fields[1] as String,
      name: fields[2] as String,
      altName: fields[3] as String,
      latitude: fields[4] as double,
      longitude: fields[5] as double,
      districts: (fields[6] as List).cast<DistrictModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RegencyModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.provinceId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.altName)
      ..writeByte(4)
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.longitude)
      ..writeByte(6)
      ..write(obj.districts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegencyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
