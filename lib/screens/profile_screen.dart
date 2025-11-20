import "package:flutter/material.dart";

import "package:citysewa/api/models.dart" show UserModel;
import "package:citysewa/screens/update_profile_screen.dart"
    show UpdateProfileScreen;

const defaultImagePath = "lib/assets/user1.webp";
const appIcon = "lib/assets/app_icon.png";

class ProfileScreen extends StatefulWidget {
  UserModel user;
  ProfileScreen({super.key, required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      backgroundColor: Color(0xfffbf0f9),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ProfileHeader(user: widget.user),
              SizedBox(height: 10),
              Settings(),
              SizedBox(height: 10),
              Others(),
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
  UserModel user;
  ProfileHeader({super.key, required this.user});

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String userName = "";
  String userGender = "";
  String userCategory = "";
  String userLocation = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userName = widget.user.firstName == ""
        ? "Your Name"
        : "${widget.user.firstName} ${widget.user.lastName}";
    userLocation = "Kathmandu";
    userGender = widget.user.gender.toLowerCase();
    userCategory = widget.user.category;
    return Container(
      padding: EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 249, 241, 241),
        border: BoxBorder.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 217, 216, 216),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                widget.user.photoUrl ?? defaultImagePath,
              ),
              radius: 45,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(userName, style: TextStyle(fontSize: 16)),
              Text("Current plan: $userCategory"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, size: 16),
                  Text(userLocation, style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UpdateProfileScreen(user: widget.user),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 170, 164),
                    borderRadius: BorderRadius.circular(20),
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

class Settings extends StatelessWidget {
  Settings({super.key});

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
        ],
      ),
    );
  }
}

class Others extends StatelessWidget {
  Others({super.key});

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
