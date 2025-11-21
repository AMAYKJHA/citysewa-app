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
      appBar: AppBar(
        title: Text("Update your profile", style: TextStyle(fontSize: 18)),
        centerTitle: true,
        toolbarHeight: 35,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Color(0xfffbf0f9),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 255, 254, 244),
          ),
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
              InkWell(
                onTap: () {
                  update(
                    firstNameController.text.toString(),
                    lastNameController.text.toString(),
                    selectedGender,
                  );
                },
                child: Container(
                  width: 70,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 244, 81, 69),
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
                  child: Center(
                    child: isUpdating
                        ? CircularProgressIndicator(
                            color: Colors.black.withAlpha(150),
                          )
                        : Text(
                            "Save",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
