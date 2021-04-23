// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthUserAdapter extends TypeAdapter<AuthUser> {
  @override
  final typeId = 3;

  @override
  AuthUser read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthUser(
      status: fields[0] as dynamic,
      userId: fields[1] as dynamic,
      name: fields[2] as dynamic,
      email: fields[3] as dynamic,
      phone: fields[4] as dynamic,
      meetingCode: fields[5] as dynamic,
      imageUrl: fields[6] as dynamic,
      gender: fields[7] as dynamic,
      role: fields[8] as dynamic,
      joinDate: fields[9] as dynamic,
      lastLogin: fields[10] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, AuthUser obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.meetingCode)
      ..writeByte(6)
      ..write(obj.imageUrl)
      ..writeByte(7)
      ..write(obj.gender)
      ..writeByte(8)
      ..write(obj.role)
      ..writeByte(9)
      ..write(obj.joinDate)
      ..writeByte(10)
      ..write(obj.lastLogin);
  }
}
