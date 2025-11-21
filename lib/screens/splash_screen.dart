import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;
import 'dart:async';

import "package:citysewa/screens/home_screen.dart" show HomeScreen;
import "package:citysewa/screens/login_screen.dart" show LoginScreen;

const appIcon = "lib/assets/app_icon.png";

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), changeScreen);
  }

  @override
  Widget build(BuildContext build) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 58, 45),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(150),
                    offset: Offset(0, 4),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(appIcon),
                radius: 70,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Services at your home",
              style: TextStyle(
                fontSize: 17,
                color: const Color.fromARGB(255, 252, 247, 247),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeScreen() async {
    final pref = await SharedPreferences.getInstance();
    bool isLoggedIn = pref.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
