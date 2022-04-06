
enum AuthStatus{
  authorized, notAuthorized, loading
}
class AuthState{
  AuthState({this.status=AuthStatus.notAuthorized});
  final AuthStatus status;

  AuthState copyWith({
    AuthStatus? status,
  }) {
    return AuthState(
      status: status ?? this.status,
    );
  }
}