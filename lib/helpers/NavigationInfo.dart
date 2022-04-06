import 'package:flutter/cupertino.dart';
import 'package:test_app/pages/auth/LoginPage.dart';
import 'package:test_app/pages/auth/SignUpPage.dart';
import 'package:test_app/pages/home/HomePage.dart';
import 'package:test_app/pages/loading/LoadingPage.dart';

/// Stores app navigation paths
class NavigationInfo{
  static const login = "login";
  static const signup = "signup";
  static const home = "home";
  static const loading = "loading";


  static makeRoutes()=>{
    home : (BuildContext c)=>const HomePage(),
    login : (BuildContext c)=>const LoginPage(),
    signup: (BuildContext c)=>const SignUpPage(),
    loading : (BuildContext c)=>const LoadingPage(),
  };

}