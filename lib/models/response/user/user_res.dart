import 'dart:convert';

List<UserResModel> UserDataFromJson(String str) => List<UserResModel>.from(
    json.decode(str).map((x) => UserResModel.fromJson(x)));

String UserResModelToJson(UserResModel data) => json.encode(data.toJson());

class UserResModel {
  UserResModel({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  final int userId;
  final String? email;
  final String firstName;
  final String lastName;
  final String? password;

  factory UserResModel.fromJson(Map<String, dynamic> json) => UserResModel(
        userId: json["user_id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": userId,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
      };
}
