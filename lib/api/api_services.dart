import "package:http/http.dart" as http;
import "dart:convert";
import "models.dart";

const baseUrl = "https://citysewa.onrender.com/api";

const authEndpoint = "$baseUrl/auth/customer";

class AuthService {
  Future<UserModel> login(String phoneNumber, String password) async {
    final url = Uri.parse("$authEndpoint/login");
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
    final url = Uri.parse("$authEndpoint/register");
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
      print("Error-> $e");
      throw Exception(e);
    }
  }
}
