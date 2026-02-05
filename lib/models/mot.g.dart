// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mot.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MotAdapter extends TypeAdapter<Mot> {
  @override
  final int typeId = 4;

  @override
  Mot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mot()
      ..idListe = fields[0] as int
      ..word = fields[1] as String
      ..image = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, Mot obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.idListe)
      ..writeByte(1)
      ..write(obj.word)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
