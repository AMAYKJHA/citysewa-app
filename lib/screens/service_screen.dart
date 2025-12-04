import "package:flutter/material.dart";

import "package:citysewa/api/api_services.dart" show ServiceAPI;

const defaultProfileImage = "https://placehold.net/avatar-1.png";

ServiceAPI serviceAPI = ServiceAPI();

class ServiceScreen extends StatefulWidget {
  final serviceId;
  ServiceScreen({super.key, required this.serviceId});

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  Future getService(int serviceId) async {
    try {
      final result = await serviceAPI.retrieveService(serviceId);
      return result;
    } catch (e) {
      print(e);
    }
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
      body: FutureBuilder(
        future: getService(widget.serviceId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.red));
          } else if (snapshot.hasData) {
            final service = snapshot.data;
            return Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          offset: Offset(0, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                "Some problem occured",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
