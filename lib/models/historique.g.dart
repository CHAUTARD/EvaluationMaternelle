// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historique.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoriqueAdapter extends TypeAdapter<Historique> {
  @override
  final int typeId = 2;

  @override
  Historique read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Historique()
      ..eleveId = fields[0] as int
      ..listeId = fields[1] as int
      ..motsReussis = (fields[2] as List).cast<String>()
      ..motsEchoues = (fields[3] as List).cast<String>()
      ..date = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Historique obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.eleveId)
      ..writeByte(1)
      ..write(obj.listeId)
      ..writeByte(2)
      ..write(obj.motsReussis)
      ..writeByte(3)
      ..write(obj.motsEchoues)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoriqueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
