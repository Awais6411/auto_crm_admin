import 'dart:convert';

AuctioneerLoginResModel AuctioneerLoginResModelFromJson(String str) =>
    AuctioneerLoginResModel.fromJson(json.decode(str));
List<AuctioneerLoginResModel> AuctioneerListResModelFromJson(String str) =>
    List<AuctioneerLoginResModel>.from(
        json.decode(str).map((x) => AuctioneerLoginResModel.fromJson(x)));

String AuctioneerLoginResModelToJson(AuctioneerLoginResModel data) =>
    json.encode(data.toJson());

class AuctioneerLoginResModel {
  AuctioneerLoginResModel({
    required this.auctionerId,
    this.status,
    required this.email,
    required this.password,
    required this.firstName,
  });

  final int auctionerId;
  final int? status;
  final String? email;
  final String? password;
  final String firstName;

  factory AuctioneerLoginResModel.fromJson(Map<String, dynamic> json) =>
      AuctioneerLoginResModel(
        auctionerId: json["auctioneer_id"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        firstName: json["first_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "email": email ?? '',
        "password": password ?? '',
        "first_name": firstName
      };
}
