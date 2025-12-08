import "package:flutter/material.dart";

// import "package:citysewa/screens/login_screen.dart";
// import "package:citysewa/screens/home_screen.dart" show HomeScreen;
// import "package:citysewa/screens/profile_screen.dart";
import "screens/splash_screen.dart";

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
