/* import 'dart:convert';

List<CarImages> CarImagesFromJson(String str) =>
    List<CarImages>.from(json.decode(str).map((x) => CarImages.fromJson(x)));

class CarImages {
  CarImages({
    required this.image_id,
    required this.car_id,
    required this.imageUrl,
  });

  final int image_id;
  final int car_id;

  final String imageUrl;

  factory CarImages.fromJson(Map<String, dynamic> json) => CarImages(
        image_id: json["image_id"],
        car_id: json["car_id"],
        imageUrl: json["imageUrl"],
      );
}
 */