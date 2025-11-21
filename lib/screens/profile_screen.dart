import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart"
    show SharedPreferences;

import "package:citysewa/screens/update_profile_screen.dart"
    show UpdateProfileScreen;

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(fontSize: 18)),
        centerTitle: true,
        toolbarHeight: 35,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Color(0xfffbf0f9),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ProfileHeader(),
              SizedBox(height: 10),
              Menus(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatefulWidget {
  ProfileHeader({super.key});

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  late String userFirstName;
  late String userLastName;
  late String userGender;
  late String userPhoto;
  late String userCategory;
  String userLocation = "Kathmandu";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      userFirstName = pref.getString('userFirstName') ?? "Your";
      userLastName = pref.getString('userLastName') ?? "Name";
      userGender = pref.getString('userGender') ?? "male";
      userPhoto = pref.getString('userPhoto') ?? "";
      userCategory = pref.getString('userCategory') ?? "BASIC";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 76, 63),
        border: BoxBorder.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userPhoto),
                  radius: 40,
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$userFirstName $userLastName",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    "Current plan: $userCategory",
                    style: TextStyle(color: Colors.black),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: 16),
                      Text(userLocation, style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1),
              ),
              child: Icon(Icons.edit, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class Menus extends StatelessWidget {
  Menus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 249, 241, 241),
        border: BoxBorder.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Settings", style: TextStyle(color: Colors.grey)),
          TileButton(text: "Account settings", action: () {}),
          TileButton(text: "Booking History", action: () {}),
          TileButton(text: "App preferences", action: () {}),
          TileButton(text: "Upgrade to premium", action: () {}),
          Divider(),
          Text("Preferencs", style: TextStyle(color: Colors.grey)),
          TileButton(text: "Notifications", action: () {}),
          TileButton(text: "Language and region", action: () {}),
          TileButton(text: "Daily activity", action: () {}),
          Divider(),
          Text("Payments", style: TextStyle(color: Colors.grey)),
          TileButton(text: "Manage ewallet", action: () {}),
          TileButton(text: "Payment history", action: () {}),
          Divider(),
          Text("Others", style: TextStyle(color: Colors.grey)),
          TileButton(text: "Blocked providers", action: () {}),
          TileButton(text: "Submit complaints", action: () {}),
          TileButton(text: "Feedback", action: () {}),
        ],
      ),
    );
  }
}

class TileButton extends StatelessWidget {
  final String text;
  final VoidCallback action;
  TileButton({super.key, required this.text, required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(text, style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
