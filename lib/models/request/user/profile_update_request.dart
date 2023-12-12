import 'dart:convert';

ProfileUpdateReqModel ProfileUpdateReqModelFromJson(String str) =>
    ProfileUpdateReqModel.fromJson(json.decode(str));

String ProfileUpdateReqModelToJson(ProfileUpdateReqModel data) =>
    json.encode(data.toJson());

class ProfileUpdateReqModel {
  ProfileUpdateReqModel(
      {required this.auctioneerId,
      required this.userName,
      required this.email,
      required this.phone});

  final int auctioneerId;
  final String userName;
  final String email;
  final String phone;

  factory ProfileUpdateReqModel.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateReqModel(
        auctioneerId: json["auctioneer_id"],
        userName: json["first_name"],
        email: json["email"],
        phone: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "auctioneer_id": auctioneerId,
        "email": email,
        'first_name': userName,
        'contact': phone
      };
}
