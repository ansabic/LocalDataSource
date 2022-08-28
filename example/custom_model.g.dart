// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomModelAdapter extends TypeAdapter<CustomModel> {
  @override
  final int typeId = 0;

  @override
  CustomModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomModel(
      first: fields[0] as String,
      second: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CustomModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.first)
      ..writeByte(1)
      ..write(obj.second);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
