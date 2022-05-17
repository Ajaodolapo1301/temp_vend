// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdap extends TypeAdapter<User> {
  @override
  final int typeId = 4;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      roleId: fields[1] as int,
      fullName: fields[2] as String,
      email: fields[3] as String,
      phone: fields[4] as String,
      profileImageUrl: fields[5] as String,
      language: fields[6] as String,
      dob: fields[7] as Null,
      homeAddress: fields[8] as Null,
      ratings: fields[9] as String,
      onboard: fields[10] as bool,
      token: fields[11] as String,
      pinId: fields[12] as dynamic,
      otp: fields[13] as dynamic,
      fcmToken: fields[14] as String,
      newUpdateNotification: fields[15] as bool,
      pushNotification: fields[16] as bool,
      smsNotification: fields[17] as bool,
      emailNotification: fields[18] as bool,
      inAppSound: fields[19] as bool,
      inAppVibrate: fields[20] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.roleId)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.profileImageUrl)
      ..writeByte(6)
      ..write(obj.language)
      ..writeByte(7)
      ..write(obj.dob)
      ..writeByte(8)
      ..write(obj.homeAddress)
      ..writeByte(9)
      ..write(obj.ratings)
      ..writeByte(10)
      ..write(obj.onboard)
      ..writeByte(11)
      ..write(obj.token)
      ..writeByte(12)
      ..write(obj.pinId)
      ..writeByte(13)
      ..write(obj.otp)
      ..writeByte(14)
      ..write(obj.fcmToken)
      ..writeByte(15)
      ..write(obj.newUpdateNotification)
      ..writeByte(16)
      ..write(obj.pushNotification)
      ..writeByte(17)
      ..write(obj.smsNotification)
      ..writeByte(18)
      ..write(obj.emailNotification)
      ..writeByte(19)
      ..write(obj.inAppSound)
      ..writeByte(20)
      ..write(obj.inAppVibrate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdap &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
