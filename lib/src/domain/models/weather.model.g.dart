// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherModelAdapter extends TypeAdapter<WeatherModel> {
  @override
  final int typeId = 1;

  @override
  WeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherModel(
      temperature: fields[0] as double,
      humidity: fields[1] as int,
      pressure: fields[2] as int,
      feelsLike: fields[3] as double?,
      tempMin: fields[4] as double,
      tempMax: fields[5] as double,
      windSpeed: fields[7] as double?,
      clouds: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.temperature)
      ..writeByte(1)
      ..write(obj.humidity)
      ..writeByte(2)
      ..write(obj.pressure)
      ..writeByte(3)
      ..write(obj.feelsLike)
      ..writeByte(4)
      ..write(obj.tempMin)
      ..writeByte(5)
      ..write(obj.tempMax)
      ..writeByte(7)
      ..write(obj.windSpeed)
      ..writeByte(8)
      ..write(obj.clouds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
