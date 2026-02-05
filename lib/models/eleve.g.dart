// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eleve.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EleveAdapter extends TypeAdapter<Eleve> {
  @override
  final int typeId = 1;

  @override
  Eleve read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Eleve()
      ..prenom = fields[0] as String
      ..niveauId = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, Eleve obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.prenom)
      ..writeByte(1)
      ..write(obj.niveauId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EleveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
