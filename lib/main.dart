import "package:flutter/material.dart";
import "screens/login_screen.dart";
import "screens/signup_screen.dart";
import "screens/home_screen.dart";
import "screens/profile_screen.dart";
// import "screens/splash_screen.dart";

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
