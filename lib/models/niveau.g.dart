// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'niveau.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NiveauAdapter extends TypeAdapter<Niveau> {
  @override
  final int typeId = 0;

  @override
  Niveau read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Niveau(
      id: fields[0] as String,
      nom: fields[1] as String,
      couleur: fields[2] as int,
      ordre: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Niveau obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.couleur)
      ..writeByte(3)
      ..write(obj.ordre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NiveauAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
