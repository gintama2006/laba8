import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laba8/screens/login/auth_page.dart';
import 'package:laba8/mainpage.dart';
import 'package:provider/provider.dart';



class LandingController extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final User? user = Provider.of<User?>(context);

    bool isLoginIn = user != null;
    return isLoginIn ? MyHomePage() : LoginScreen();

  }
}