// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packageSize.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackageSizeAdapter extends TypeAdapter<PackageSize> {
  @override
  final int typeId = 3;

  @override
  PackageSize read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PackageSize(
      title: fields[0] as String,
      weightUnit: fields[1] as String,
      minWeight: fields[2] as int,
      maxWeight: fields[3] as int,
      range: fields[4] as String,
      imageUrl: fields[5] as String,
      status: fields[6] as int,
      priceEffect: fields[7] as String,
      id: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PackageSize obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.weightUnit)
      ..writeByte(2)
      ..write(obj.minWeight)
      ..writeByte(3)
      ..write(obj.maxWeight)
      ..writeByte(4)
      ..write(obj.range)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.priceEffect)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageSizeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
