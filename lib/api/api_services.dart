import "package:http/http.dart" as http;
import "dart:convert";
import "models.dart";

const baseUrl = "https://citysewa.onrender.com/api";

const authEndpoint = "$baseUrl/auth/customer";

// final endpoints = {
//   "REGISTER": "customer/register",
//   "LOGIN": "login",
// };

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
}
