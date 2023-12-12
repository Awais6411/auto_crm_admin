import 'dart:convert';

List<CarData> CarDataFromJson(String str) =>
    List<CarData>.from(json.decode(str).map((x) => CarData.fromJson(x)));

class CarData {
  CarData({
    this.vehicleId,
    this.vin,
    this.opportunityId,
    required this.year,
    required this.make,
    required this.model,
    this.trim,
    this.mileage,
    this.saleStatus,
    required this.color,
    required this.details,
    this.reserve,
    this.imageUrl,
    this.status,
    this.soldPrice,
    this.conditionLight,
    this.anoucements,
    this.userId,
    this.auctionName,
    this.laneNumber,
    this.imagesListIds,
  });

  final int? vehicleId;
  final String? vin;
  final String year;
  final String make;
  final String model;
  final String? trim;
  final String? mileage;
  final String color;

  final String details;
  final String? reserve;
  final String? imageUrl;
  final bool? status;
  final int? soldPrice;
  final String? conditionLight;
  final String? saleStatus;
  final String? anoucements;
  final int? opportunityId;
  final int? userId;
  final String? auctionName;
  final String? laneNumber;
  List<int?>? imagesListIds;
  factory CarData.fromJson(Map<String, dynamic> json) => CarData(
      vehicleId: json["vehicle_id"] ?? 1,
      vin: json["vin"] ?? "TESTING",
      year: json["year"] ?? "TESTING",
      make: json["make"] ?? "TESTING",
      model: json["model"] ?? "TESTING",
      trim: json["trim"] ?? "TESTING",
      mileage: json["mileage"] ?? "TESTING",
      color: json["color"] ?? "TESTING",
      details: json["details"] ?? "TESTING",
      reserve: json["reserve"] ?? "TESTING",
      imageUrl: json["imageUrl"] ?? "TESTING",
      saleStatus: json["sale_status"] ?? "TESTING",
      status: json["status"] ?? false,
      soldPrice: json["sold_price"] ?? 2000,
      conditionLight: json["condition_light"] ?? "TESTING",
      anoucements: json["annoucements"] ?? "TESTING",
      auctionName: json["auction_name"] ?? "TESTING",
      laneNumber: json["lane_name"] ?? "TESTING",
      opportunityId: json["opportunity_id"] ?? 1,
      userId: json["user_id"] ?? 1);

  Map<String, dynamic> toJson() => {
        "year": year,
        "make": make,
        'model': model,
        'color': color,
        'mileage': mileage,
        'vin': vin,
        'details': details,
        'imagesListIds': imagesListIds,
      };
}
