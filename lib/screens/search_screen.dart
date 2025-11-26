import "package:flutter/material.dart";

import "package:citysewa/api/api_services.dart" show ProviderService;

const defaultProfileImage = "https://placehold.net/avatar-1.png";
ProviderService provider = ProviderService();

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? serviceType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.red),
      backgroundColor: Color(0xfffbf0f9),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SearchBar(
              onSubmit: (value) {
                setState(() {
                  serviceType = value;
                });
              },
            ),
            SizedBox(height: 10),
            Expanded(child: SearchResult(serviceType: serviceType)),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function(String) onSubmit;
  SearchBar({super.key, required this.onSubmit});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            offset: const Offset(0, 4),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextField(
        autofocus: true,
        cursorColor: Colors.red,
        enableSuggestions: true,
        keyboardType: TextInputType.text,
        onSubmitted: (value) {
          widget.onSubmit(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(Icons.search),
          hintText: "Search for services",
          hintStyle: TextStyle(fontSize: 15),
          fillColor: Color(0xffffffff),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

class SearchResult extends StatefulWidget {
  final String? serviceType;
  const SearchResult({super.key, required this.serviceType});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List providerList = [];

  @override
  void initState() {
    super.initState();
  }

  Future fetchProvider(String serviceType) async {
    List list = [];
    try {
      final result = await provider.getProvider(serviceType = serviceType);
      list = result['results'];
      setState(() {
        providerList = list;
      });
    } catch (e) {
      print(e);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.serviceType != null) {
      fetchProvider(widget.serviceType!);
    } else {}
    return ListView.builder(
      itemCount: providerList.length,
      itemBuilder: (context, index) {
        return ProviderTile(
          firstName: providerList[index]['first_name'],
          lastName: providerList[index]['last_name'],
          serviceType: providerList[index]['service_type'],
          photoUrl: providerList[index]['photo'],
        );
      },
    );
  }
}

class ProviderTile extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String serviceType;
  final String? photoUrl;
  ProviderTile({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.serviceType,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(photoUrl ?? defaultProfileImage),
              radius: 30,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                "$firstName $lastName",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(serviceType, style: TextStyle(fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
}
