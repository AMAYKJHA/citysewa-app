import "package:flutter/material.dart";

import "package:citysewa/api/models.dart" show UserModel;

class UpdateProfileScreen extends StatefulWidget {
  UserModel user;
  UpdateProfileScreen({super.key, required this.user});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update your profile")),
      backgroundColor: Color(0xfffbf0f9),
      body: Container(padding: EdgeInsets.all(10)),
    );
  }
}
