// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthDataAdapter extends TypeAdapter<AuthData> {
  @override
  final int typeId = 3;

  @override
  AuthData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthData(
      id: fields[0] as int,
      token: fields[1] as String,
      validUntil: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AuthData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.validUntil);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
