import 'package:hive/hive.dart';

import 'abstract/Model.dart';

part 'AuthData.g.dart';

@HiveType(typeId: 3)
class AuthData extends Model{

  @override
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String token;
  @HiveField(2)
  final DateTime validUntil;


  @override
  List<Object?> get props => [id, token, validUntil];

  AuthData({
    required this.id,
    required this.token,
    required this.validUntil,
  });

}