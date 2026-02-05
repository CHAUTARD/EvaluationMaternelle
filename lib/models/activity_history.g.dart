// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityHistoryAdapter extends TypeAdapter<ActivityHistory> {
  @override
  final int typeId = 6;

  @override
  ActivityHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityHistory()
      ..studentId = fields[0] as int
      ..listId = fields[1] as int
      ..date = fields[2] as DateTime
      ..durationInSeconds = fields[3] as int
      ..words = (fields[4] as List).cast<String>()
      ..status = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, ActivityHistory obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.studentId)
      ..writeByte(1)
      ..write(obj.listId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.durationInSeconds)
      ..writeByte(4)
      ..write(obj.words)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
