
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/auth/AuthState.dart';
import 'package:test_app/models/AuthData.dart';
import 'package:test_app/repos/AuthLocalDataLoader.dart';
import 'package:test_app/repos/LocalDataLoader.dart';


/// Manages user authentication
class AuthCubit extends Cubit<AuthState>{
  AuthCubit({required AuthLocalDataLoader authDataLoader}) : _authDataLoader = authDataLoader,  super(AuthState(status: AuthStatus.loading));

  final AuthLocalDataLoader _authDataLoader;

  /// Checks authentication status
  ///
  /// probably should be used only on the app start
  checkAuth()async{
    AuthData? authData = await _authDataLoader.load(0);
    if(authData == null || authData.validUntil.isBefore(DateTime.now())){
      emit(state.copyWith(status: AuthStatus.notAuthorized));
    }
    else{
      emit(state.copyWith(status: AuthStatus.authorized));
    }
  }

  /// Tries to log in with provided [email] and [password]
  ///
  /// returns error message if log in attempt is unsuccessful
  Future<String?> logIn(String email, String password)async{
    emit(state.copyWith(status: AuthStatus.loading));
    await _authDataLoader.save(AuthData(id: 0, token: "someToken", validUntil: DateTime.now().add(const Duration(days: 1))));
    emit(state.copyWith(status: AuthStatus.authorized));
  }

  /// Tries to sign up with provided [email] and [password]
  ///
  /// returns error message if sign up attempt is unsuccessful
  Future<String?> signUp(String email, String password)async{
  }


  /// Logs out user
  logOut()async{
    emit(state.copyWith(status: AuthStatus.loading));
    await _authDataLoader.delete(0);
    emit(state.copyWith(status: AuthStatus.notAuthorized));
  }

}