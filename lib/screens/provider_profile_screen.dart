import "package:flutter/material.dart";

const defaultProfileImage = "https://placehold.net/avatar-1.png";

class ProviderProfileScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String serviceType;
  final String? photoUrl;
  ProviderProfileScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.serviceType,
    this.photoUrl,
  });

  @override
  _ProviderProfileScreenState createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.red),
      backgroundColor: Color(0xfffbf0f9),
      body: Padding(
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
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.photoUrl ?? defaultProfileImage,
                      ),
                      radius: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${widget.firstName} ${widget.lastName}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("4.5 ", style: TextStyle(fontSize: 13)),
                              Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.yellow[600],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(widget.serviceType),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Column(
                children: [
                  Text("Availabe From: 09:00 am To: 04:00 pm"),
                  Text("Bookings completed: 39"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
