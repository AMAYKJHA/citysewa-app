import "package:flutter/material.dart";

import "package:citysewa/api/models.dart" show UserModel;

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
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage(defaultImagePath), radius: 60),
                Text("Tessa Thompson",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
                Text("Kathmandu, Nepal", style: TextStyle(fontSize: 18)),
                Divider(),
                SizedBox(height: 10),
                Tile(text: "Account settings"),
                Tile(text: "Bookings"),
                Tile(text: "App preferences"),
                Tile(text: "Upgrade to premium"),
                SizedBox(
                  height: 30,
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text("Rate our service",
                            style: TextStyle(fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {},
                                child:
                                    Icon(Icons.star_border_outlined, size: 30)),
                            InkWell(
                                onTap: () {},
                                child:
                                    Icon(Icons.star_border_outlined, size: 30)),
                            InkWell(
                                onTap: () {},
                                child:
                                    Icon(Icons.star_border_outlined, size: 30)),
                            InkWell(
                                onTap: () {},
                                child:
                                    Icon(Icons.star_border_outlined, size: 30)),
                            InkWell(
                                onTap: () {},
                                child:
                                    Icon(Icons.star_border_outlined, size: 30)),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}

class Tile extends StatelessWidget {
  final String text;
  const Tile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 350,
        ),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            this.text,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
