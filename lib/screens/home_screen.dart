import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart"
    show SharedPreferences;
import "package:citysewa/screens/profile_screen.dart" show ProfileScreen;
import "package:citysewa/screens/notification_screen.dart"
    show NotificationScreen;
import "package:citysewa/screens/widgets.dart";

const appIcon = "lib/assets/app_icon.png";

const List<List<Widget>> popularServices = [
  [
    Text(
      "Electrician",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    Icon(Icons.electric_bolt_rounded, size: 60),
  ],
  [
    Text(
      "Home Tution",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    Icon(Icons.school, size: 60),
  ],
  [
    Text(
      "Plumber",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    Icon(Icons.plumbing, size: 60),
  ],
  [
    Text(
      "House Help",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    Icon(Icons.house, size: 60),
  ],
];
const List<List<Widget>> offers = [
  [
    Text(
      "Save upto 60%",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    Icon(Icons.workspace_premium, size: 60),
  ],
  [
    Text(
      "Festive offer",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    Icon(Icons.emoji_people_rounded, size: 60),
  ],
];

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.red),
      backgroundColor: Color(0xfffbf0f9),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Header(),
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
                    const SizedBox(height: 10),
                    Carousel(
                      title: "Popular services",
                      tilesContent: popularServices,
                      tileSize: (150.0, 120.0),
                      tilesColor: [
                        Color.fromARGB(255, 252, 83, 71),
                        Color.fromARGB(255, 249, 165, 159),
                        Color(0xffffffff),
                      ],
                    ),
                    SizedBox(height: 10),
                    Carousel(
                      title: "Offers",
                      tilesContent: offers,
                      tileSize: (200.0, 120.0),
                      tilesColor: const [
                        Color.fromARGB(255, 250, 95, 84),
                        Color.fromARGB(255, 249, 165, 159),
                        Color(0xffffffff),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatefulWidget {
  Header({super.key});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late String userFirstName;
  late String userPhoto;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      userFirstName = pref.getString('userFirstName') ?? "";
      userPhoto = pref.getString('userPhoto') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(userPhoto),
                    radius: 20,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hi,",
                    style: TextStyle(
                      color: Color.fromARGB(255, 37, 37, 37),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    userFirstName,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 37, 37, 37),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(appIcon),
                radius: 20,
              ),
            ),
          ),
        ],
      ),
    );
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
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            offset: const Offset(4, 4),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
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
