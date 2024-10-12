// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderAdapter extends TypeAdapter<Reminder> {
  @override
  final int typeId = 1;

  @override
  Reminder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reminder(
      text: fields[0] as String,
      date: fields[1] as DateTime,
      isCompleted: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Reminder obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OngoingEventAdapter extends TypeAdapter<OngoingEvent> {
  @override
  final int typeId = 1;

  @override
  OngoingEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OngoingEvent(
      imagePath: fields[0] as String,
      expiryDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, OngoingEvent obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.expiryDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OngoingEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MemoryAdapter extends TypeAdapter<Memory> {
  @override
  final int typeId = 2;

  @override
  Memory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Memory(
      imagePath: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Memory obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
