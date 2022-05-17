// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deliveryType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryTypeAdapter extends TypeAdapter<DeliveryType> {
  @override
  final int typeId = 2;

  @override
  DeliveryType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryType(
      id: fields[0] as dynamic,
      minWeight: fields[1] as dynamic,
      maxWeight: fields[2] as dynamic,
      status: fields[3] as dynamic,
      priceEffect: fields[4] as dynamic,
      imageUrl: fields[5] as String,
      name: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryType obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.minWeight)
      ..writeByte(2)
      ..write(obj.maxWeight)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.priceEffect)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
