// class LoginModel {
//   String? token;
//   int? userId;

//   LoginModel({this.token, this.userId});

//   LoginModel.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     userId = json['userId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['token'] = token;
//     data['userId'] = userId;
//     return data;
//   }
// }

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? photoUrl;
  String gender;
  String category;
  String token;

  UserModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.photoUrl,
      required this.gender,
      required this.category,
      required this.token});

  UserModel.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        photoUrl = json['photo'],
        gender = json['gender'] ?? "MALE",
        category = json['category'] ?? "BASIC",
        token = json['token'];
}

// class RegisterModel {
//   String? phoneNumber;
//   String? password;

//   RegisterModel({this.phoneNumber, this.password});
// }
