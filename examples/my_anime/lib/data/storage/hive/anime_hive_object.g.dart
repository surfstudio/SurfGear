// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_hive_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimeHiveObjectAdapter extends TypeAdapter<AnimeHiveObject> {
  @override
  final int typeId = 0;

  @override
  AnimeHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnimeHiveObject(
      fields[0] as int,
      fields[1] as String,
      fields[2] as int,
      fields[3] as String,
      fields[4] as int,
      fields[5] as int,
      fields[6] as double,
      fields[7] as String,
      fields[8] as String,
      fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AnimeHiveObject obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.endDate)
      ..writeByte(2)
      ..write(obj.episodes)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.members)
      ..writeByte(5)
      ..write(obj.rank)
      ..writeByte(6)
      ..write(obj.score)
      ..writeByte(7)
      ..write(obj.startDate)
      ..writeByte(8)
      ..write(obj.title)
      ..writeByte(9)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimeHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
