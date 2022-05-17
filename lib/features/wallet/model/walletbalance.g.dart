// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walletbalance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class Wallet extends TypeAdapter<WalletBalance> {
  @override
  final int typeId = 5;

  @override
  WalletBalance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletBalance(
      balance: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WalletBalance obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.balance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Wallet &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
