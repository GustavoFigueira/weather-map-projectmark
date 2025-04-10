// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CityModelAdapter extends TypeAdapter<CityModel> {
  @override
  final int typeId = 0;

  @override
  CityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CityModel(
      id: fields[0] as int,
      label: fields[1] as String,
      name: fields[2] as String,
      state: fields[3] as String,
      country: fields[4] as String,
      countryShort: fields[5] as String,
      lat: fields[6] as String,
      long: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CityModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.state)
      ..writeByte(4)
      ..write(obj.country)
      ..writeByte(5)
      ..write(obj.countryShort)
      ..writeByte(6)
      ..write(obj.lat)
      ..writeByte(7)
      ..write(obj.long);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
