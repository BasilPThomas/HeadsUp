import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:headsup/user/login_screen.dart';
import 'package:headsup/user/nav_bar.dart';
import 'package:headsup/utilities/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 runApp(MaterialApp(
     home:MyApp(),
     debugShowCheckedModeBanner: false,
 ));
}

class MyApp extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
