// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'second_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SecondModelAdapter extends TypeAdapter<SecondModel> {
  @override
  final int typeId = 1;

  @override
  SecondModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SecondModel(
      third: fields[0] as String,
      forth: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SecondModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.third)
      ..writeByte(1)
      ..write(obj.forth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecondModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
