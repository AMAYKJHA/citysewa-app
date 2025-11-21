import "package:flutter/material.dart";

import "package:citysewa/screens/update_profile_screen.dart"
    show UpdateProfileScreen;
import "package:shared_preferences/shared_preferences.dart"
    show SharedPreferences;

const appIcon = "lib/assets/app_icon.png";

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
              RatingPannel(),
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
        color: Colors.red,
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
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateProfileScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 214, 245, 250),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(150),
                        offset: Offset(0, 2),
                        blurRadius: 2,
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [Text("Edit "), Icon(Icons.edit, size: 16)],
                  ),
                ),
              ),
            ],
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
          SizedBox(height: 15),
          Text("Others", style: TextStyle(color: Colors.grey)),
          TileButton(text: "Blocked providers", action: () {}),
          TileButton(text: "Submit complaints", action: () {}),
          TileButton(text: "Activity", action: () {}),
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
      child: Text(text, style: TextStyle(fontSize: 15)),
    );
  }
}

class RatingPannel extends StatefulWidget {
  RatingPannel({super.key});

  @override
  _RatingPannelState createState() => _RatingPannelState();
}

class _RatingPannelState extends State<RatingPannel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text("Rate our service", style: TextStyle(fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Icon(Icons.star_border_outlined, size: 30),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.star_border_outlined, size: 30),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.star_border_outlined, size: 30),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.star_border_outlined, size: 30),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.star_border_outlined, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
