import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Auth/login_screen.dart';
import '../screens/home_screen.dart';

class SplashServices{

  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;

    final user =  auth.currentUser ;

    if(user != null){
      Timer(const Duration(seconds: 3),
              ()=> Navigator.of(context).pushReplacementNamed(HomeScreen.routeName)
      );
    }else {
      Timer(const Duration(seconds: 3),
              ()=> Navigator.of(context).pushReplacementNamed(LoginScreen.routeName)
      );
    }


  }
}