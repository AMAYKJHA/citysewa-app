import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart"
    show SharedPreferences;

// import "package:citysewa/screens/profile_screen.dart" show ProfileScreen;
import "package:citysewa/screens/notification_screen.dart"
    show NotificationScreen;
import "package:citysewa/screens/search_screen.dart" show SearchScreen;
import "package:citysewa/screens/service_screen.dart" show ServiceScreen;
import "package:citysewa/api/api_services.dart" show ServiceAPI;
import "package:citysewa/screens/widgets.dart" show ServiceCarousel;

const appIcon = "lib/assets/app_icon.png";
const placeholderImage = {
  "G": "https://placehold.co/400x300/ffffff/ff0000.png?text=G&font=lato",
  "imgList": [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  ],
};

ServiceAPI service = ServiceAPI();
// final List<String> imageList = [
//   "lib/assets/image_1.png",
//   "lib/assets/image_2.png",
//   "lib/assets/image_3.png",
//   "lib/assets/image_4.png",
// ];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List featuredService = [];
  Future<List?> getServiceCarousel() async {
    try {
      final result = await service.serviceCarousel();
      return result['results'];
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List?> getFeaturedService() async {
    try {
      final result = await service.featuredService();
      return result['results'];
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.red),
      backgroundColor: Color(0xfffbf0f9),
      body: Column(
        children: [
          Header(),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  SizedBox(height: 10),
                  SearchBar(),
                  const SizedBox(height: 15),
                  FutureBuilder(
                    future: getServiceCarousel(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 200),
                            child: ServiceCarousel(
                              context: context,
                              itemList: snapshot.data!,
                            ),
                          );
                        }
                      }
                      return SizedBox(width: 0, height: 0);
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Featured services",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 41, 41, 41),
                    ),
                  ),
                  SizedBox(height: 5),
                  FutureBuilder(
                    future: getFeaturedService(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        final itemList = snapshot.data!;
                        return SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: itemList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ServiceScreen(
                                        serviceId: itemList[index]["service"],
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      itemList[index]["thumbnail"]["image"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return SizedBox(width: 0, height: 0);
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Popular services",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 41, 41, 41),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
      userFirstName = pref.getString('userFirstName') ?? "Guest";
      userPhoto =
          pref.getString('userPhoto') ?? placeholderImage['G'].toString();
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ProfileScreen()),
                  // );
                },
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(userPhoto),
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
                color: Colors.transparent,
              ),
              child: Icon(Icons.notifications, size: 28, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              offset: Offset(0, 4),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search),
            SizedBox(width: 10),
            Text("Search for services", style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
