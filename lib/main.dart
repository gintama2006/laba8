import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laba8/screens/login/auth_page.dart';
import 'package:laba8/screens/regisr//registration_page.dart';
import 'package:provider/provider.dart';
import 'package:laba8/screens/login/auth_servise.dart';
import 'package:laba8/pageController.dart';



String formatTime(int seconds){
  return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8,'0');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "",
        appId: "",
        messagingSenderId: "",
        projectId: "",
        storageBucket: ""
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: AuthServise().currentUser,
        initialData: null,
      child: MaterialApp(
        title: 'Player',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LandingController()
      ),
    );


  }
}


