// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liste.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListeAdapter extends TypeAdapter<Liste> {
  @override
  final int typeId = 3;

  @override
  Liste read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Liste()
      ..nom = fields[0] as String
      ..image = fields[1] as String
      ..motsIds = (fields[2] as List).cast<int>()
      ..niveauId = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, Liste obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nom)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.motsIds)
      ..writeByte(3)
      ..write(obj.niveauId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
