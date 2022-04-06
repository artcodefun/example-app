import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_app/bloc/auth/AuthCubit.dart';
import 'package:test_app/bloc/auth/AuthState.dart';
import 'package:test_app/helpers/NavigationInfo.dart';

class AuthNavigationWidget extends StatefulWidget {
  const AuthNavigationWidget(
      {Key? key,
      required this.child,
      required GlobalKey<NavigatorState> navKey})
      : _navKey = navKey,
        super(key: key);
  final Widget child;
  final GlobalKey<NavigatorState> _navKey;

  @override
  State<AuthNavigationWidget> createState() => _AuthNavigationWidgetState();
}

class _AuthNavigationWidgetState extends State<AuthNavigationWidget> {

  firstAuthCheck(){
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if(widget._navKey.currentState==null){
        return firstAuthCheck();
      }
      //checks authentication status when _navKey is first attached to a Navigator
      Provider.of<AuthCubit>(context, listen: false).checkAuth();
    });
  }

  @override
  void initState() {
    firstAuthCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (BuildContext context, state) {
          switch (state.status) {
            case AuthStatus.authorized:
              widget._navKey.currentState?.pushNamedAndRemoveUntil(
                  NavigationInfo.home, (route) => false);
              break;
            case AuthStatus.notAuthorized:
              widget._navKey.currentState?.pushNamedAndRemoveUntil(
                  NavigationInfo.login, (route) => false);
              break;
            case AuthStatus.loading:
              widget._navKey.currentState?.pushNamedAndRemoveUntil(
                  NavigationInfo.loading, (route) => false);
              break;
          }
        },
        child: widget.child);
  }
}
