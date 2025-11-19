import "package:flutter/material.dart";

import "package:citysewa/screens/profile_screen.dart";
import "package:citysewa/screens/widgets.dart";
import "package:citysewa/api/models.dart" show UserModel;

const defaultProfilePhoto = "lib/assets/user1.webp";
const appIcon = "lib/assets/app_icon.png";

const List<List<Widget>> popularServices = [
  [
    Text("Electrician",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    Icon(Icons.electric_bolt_rounded, size: 60),
  ],
  [
    Text("Home Tution",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    Icon(Icons.school, size: 60),
  ],
  [
    Text("Plumber",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    Icon(Icons.plumbing, size: 60),
  ],
  [
    Text("House Help",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    Icon(Icons.house, size: 60),
  ],
];
const List<List<Widget>> offers = [
  [
    Text("Save upto 60%",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    Icon(Icons.workspace_premium, size: 60)
  ],
  [
    Text("Festive offer",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    Icon(Icons.emoji_people_rounded, size: 60)
  ]
];

class HomeScreen extends StatefulWidget {
  UserModel user;
  HomeScreen({super.key, required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffbf0f9),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Header(user: widget.user),
              SizedBox(height: 10),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchBar(),
                        const SizedBox(
                          height: 10,
                        ),
                        Carousel(
                          title: "Popular services",
                          tilesContent: popularServices,
                          tileSize: (150.0, 120.0),
                          tilesColor: [
                            Color.fromARGB(255, 255, 252, 246),
                            Colors.white,
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Carousel(
                          title: "Offers",
                          tilesContent: offers,
                          tileSize: (200.0, 120.0),
                          tilesColor: const [
                            Color(0xff6db6fe),
                            Color(0xffbeddfb),
                            Color(0xffffffff),
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}

class Header extends StatefulWidget {
  UserModel user;
  Header({super.key, required this.user});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 248, 239, 239),
            Color.fromARGB(255, 249, 139, 131),
            Color.fromARGB(255, 250, 25, 8),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          // color: Colors.red,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(user: widget.user)));
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            widget.user.photoUrl ?? defaultProfilePhoto),
                        radius: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hi,",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 16),
                        ),
                        Text(
                          widget.user.firstName ?? "there",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage(appIcon),
                  radius: 20,
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(Icons.location_city_rounded, color: Colors.white),
                  Text("Kathmandu, Nepal",
                      style: TextStyle(fontSize: 16, color: Colors.white))
                ],
              ),
            ),
          ],
        ));
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          offset: const Offset(4, 4),
          blurRadius: 5,
          spreadRadius: 0,
        ),
      ]),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search for services",
          hintStyle: TextStyle(fontSize: 18),
          fillColor: Color(0xffffffff),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
