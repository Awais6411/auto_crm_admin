import 'dart:convert';

AuctioneerLoginReqModel AuctioneerLoginReqModelFromJson(String str) =>
    AuctioneerLoginReqModel.fromJson(json.decode(str));

String AuctioneerLoginReqModelToJson(AuctioneerLoginReqModel data) =>
    json.encode(data.toJson());

class AuctioneerLoginReqModel {
  AuctioneerLoginReqModel({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  factory AuctioneerLoginReqModel.fromJson(Map<String, dynamic> json) =>
      AuctioneerLoginReqModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
