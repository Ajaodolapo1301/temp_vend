// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryTimeAdapter extends TypeAdapter<DeliveryTime> {
  @override
  final int typeId = 1;

  @override
  DeliveryTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryTime(
      id: fields[0] as dynamic,
      name: fields[1] as dynamic,
      description: fields[2] as dynamic,
      priceEffect: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryTime obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.priceEffect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
