import 'package:flutter/material.dart';
import '../../../models/response/vehicle/vehicle.dart';
import '../../../services/config.dart';
import '../styles/custom_google_fonts.dart';

class AuctionCarCardView extends StatefulWidget {
  final List<CarData>? data;

  final String year;
  final int car_id;
  final String make;
  final String color;
  final String? model;
  final String? details;
  final String? auctionName;
  final String? laneNumber;
  final String imageUrl;
  final bool? showCheckBox;
  final int? status;

  final void Function()? onTap;

  const AuctionCarCardView({
    super.key,
    this.data,
    required this.imageUrl,
    required this.year,
    required this.make,
    required this.color,
    required this.model,
    required this.details,
    required this.car_id,
    this.showCheckBox,
    this.onTap,
    this.status,
    this.auctionName,
    this.laneNumber,
  });

  @override
  State<AuctionCarCardView> createState() => _AuctionCarCardViewState();
}

class _AuctionCarCardViewState extends State<AuctionCarCardView> {
  final List<int> adminIds = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromARGB(255, 47, 90, 125),
              // Set the desired border color
              width: 1, // Set the desired border width
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.year,
                            style: customGoolgeFonts(
                                Colors.black.withOpacity(0.7),
                                FontWeight.w500,
                                20)),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(widget.make,
                            style: customGoolgeFonts(
                                Colors.black.withOpacity(0.7),
                                FontWeight.w500,
                                20)),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          widget.model ?? "S Class",
                          style: customGoolgeFonts(
                              Colors.black.withOpacity(0.7),
                              FontWeight.w500,
                              20),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    widget.showCheckBox != true
                        ? Text(
                            "${widget.auctionName}:Lane ${widget.laneNumber}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.7)),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 248, 231, 230),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromARGB(255, 47, 90, 125),
                        width: 1, // Set the desired border width
                      ),
                    ),
                    child: Image.network(
                      '${Config.SERVER_IMAGES_URL}/${widget.imageUrl}',
                      height: 90,
                      width: 90,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
