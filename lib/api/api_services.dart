import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart"
    show SharedPreferences;
import "dart:convert";

import "models.dart";

const baseUrl = "https://citysewa.onrender.com/api";

const authEndpoint = "$baseUrl/auth/customer";
const loginEndpoint = "$authEndpoint/login";
const registerEndpoint = "$authEndpoint/register";
const getProviderEndpoint = "$baseUrl/auth/provider/list";

class AuthService {
  Future<UserModel> login(String phoneNumber, String password) async {
    final url = Uri.parse(loginEndpoint);
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone_number": phoneNumber, "password": password}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
          "Login failed: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  Future<bool> register(String phoneNumber, String password) async {
    var registerSuccess = false;
    final url = Uri.parse(registerEndpoint);
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone_number": phoneNumber, "password": password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        registerSuccess = true;
        return registerSuccess;
      } else {
        throw Exception("Register failed: ${response.body}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map> updateProfile(
    String firstName,
    String lastName,
    String gender,
    String? imagePath,
  ) async {
    var url = Uri.parse("$authEndpoint/update");
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString('userToken')!;
    try {
      var request = http.MultipartRequest('PATCH', url);
      if (firstName != '') {
        request.fields['first_name'] = firstName;
      }
      if (firstName != '') {
        request.fields['last_name'] = lastName;
      }
      request.fields['gender'] = gender;
      if (imagePath != null) {
        request.files.add(
          await http.MultipartFile.fromPath('photo', imagePath),
        );
      }
      request.headers.addAll({
        'Authorization': "Token $token",
        "Accept": "application/json",
      });
      final responseStream = await request.send();
      final response = await http.Response.fromStream(responseStream);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }
}

class ProviderService {
  Future<Map> getProvider(String serviceType) async {
    final url = Uri.parse("$getProviderEndpoint?service_type=$serviceType");
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString('userToken')!;

    try {
      final response = await http.get(
        url,
        headers: {"Authorization": "Token $token"},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        print(response.statusCode);
        throw Exception("Bad response");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
