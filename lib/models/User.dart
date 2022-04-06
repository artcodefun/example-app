import 'package:hive/hive.dart';
import 'package:test_app/models/abstract/Serializer.dart';

import 'abstract/Model.dart';

part 'User.g.dart';

@HiveType(typeId: 0)
class User extends Model {
  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.avatar,
      required this.email,
      required this.age,
      required this.gender,
      required this.maritalStatus,
      required this.phone,
      required this.website});

  @override
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String username;
  @HiveField(4)
  final String avatar;
  @HiveField(5)
  final String email;
  @HiveField(6)
  final int age;
  @HiveField(7)
  final String gender;
  @HiveField(8)
  final String maritalStatus;
  @HiveField(9)
  final String phone;
  @HiveField(10)
  final String website;

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? username,
    String? avatar,
    String? email,
    int? age,
    String? gender,
    String? maritalStatus,
    String? phone,
    String? website,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      phone: phone ?? this.phone,
      website: website ?? this.website,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        username,
        avatar,
        email,
        age,
        gender,
        maritalStatus,
        phone,
        website
      ];
}

class UserSerializer implements Serializer<User> {
  @override
  User fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"],
      firstName: map["firstName"],
      lastName: map["lastName"],
      username: map["username"],
      avatar: map["avatar"],
      email: map["email"],
      age: map["age"],
      gender: map["gender"],
      maritalStatus: map["maritalStatus"],
      phone: map["phone"],
      website: map["website"],
    );
  }

  @override
  Map<String, dynamic> toMap(User model) {
    return {
      "id": model.id,
      "firstName": model.firstName,
      "lastName": model.lastName,
      "username": model.username,
      "avatar": model.avatar,
      "email": model.email,
      "age": model.age,
      "gender": model.gender,
      "maritalStatus": model.maritalStatus,
      "phone": model.phone,
      "website": model.website,
    };
  }
}
