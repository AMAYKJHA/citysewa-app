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
    Timer(const Duration(seconds: 3), changeScreen);
  }

  @override
  Widget build(BuildContext build) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 252, 52, 52),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(appIcon),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Services at your home",
              style: TextStyle(
                fontSize: 17,
                color: const Color.fromARGB(255, 252, 247, 247),
                fontWeight: FontWeight.w500,
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
