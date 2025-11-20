import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart"
    show SharedPreferences;

import "package:citysewa/api/api_services.dart" show AuthService;

AuthService auth = AuthService();

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({super.key});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool isUpdating = false;
  String selectedGender = "MALE";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void update(String firstName, String lastName, String gender) async {
    setState(() {
      isUpdating = true;
    });
    try {
      final updatedDetails = await auth.updateProfile(
        firstName,
        lastName,
        gender,
      );
      final pref = await SharedPreferences.getInstance();
      pref.setString('userFirstName', updatedDetails['first_name']);
      pref.setString('userLastName', updatedDetails['last_name']);
      pref.setString('userGender', updatedDetails['gender']);
      pref.setString('userPhoto', updatedDetails['photo']);
    } catch (e) {
      print(e);
    }
    setState(() {
      isUpdating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update your profile")),
      backgroundColor: Color(0xfffbf0f9),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("First Name"),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 40,
              child: TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: const Color.fromARGB(255, 249, 101, 101),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Last Name"),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 40,
              child: TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: const Color.fromARGB(255, 249, 101, 101),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Gender"),
            Container(
              child: Row(
                children: [
                  RadioMenuButton(
                    value: "MALE",
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                    },
                    child: Text("male"),
                  ),
                  RadioMenuButton(
                    value: "FEMALE",
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() => selectedGender = value!);
                    },
                    child: Text("female"),
                  ),
                  RadioMenuButton(
                    value: "OTHERS",
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                    },
                    child: Text("other"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 155, 148),
              ),
              onPressed: () {
                update(
                  firstNameController.text.toString(),
                  lastNameController.text.toString(),
                  selectedGender,
                );
              },
              child: isUpdating
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
