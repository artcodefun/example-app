import 'package:test_app/models/User.dart';

class UserState{
  final User? user;

  UserState copyWith({
    User? user,
  }) {
    return UserState(
      user: user ?? this.user,
    );
  }

  const UserState({
     this.user,
  });
}