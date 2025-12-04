import "package:flutter/material.dart";
import "package:flutter_html/flutter_html.dart";

import "package:citysewa/api/api_services.dart" show ServiceAPI;
import "package:citysewa/screens/widgets.dart" show Carousel;

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
            List imgList = [];
            for (Map image in service['gallery']) {
              imgList.add(image['image']);
            }
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Carousel(itemList: imgList),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        service['title'],
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 51, 51, 51),
                        ),
                      ),
                      Text(
                        "Rs.${service['price']}${service['pricing_type']}",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),
                  Text(
                    "By ${service['provider']['first_name']} ${service['provider']['last_name']}",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 10),
                  Text("Description", style: TextStyle(fontSize: 18)),
                  Container(
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
                    child: Html(
                      data: service['description'],
                      style: {"p": Style(fontSize: FontSize(15))},
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Book service",
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 46, 46, 46),
                      ),
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
                overflow: TextOverflow.ellipsis,
              ),
            );
          }
        },
      ),
    );
  }
}
