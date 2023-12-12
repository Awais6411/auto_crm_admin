import 'package:flutter/material.dart';
import '../../ui/oppurtunities/auction_cars_list.dart';

class AuctioneerContainer extends StatefulWidget {
  final String name;
  int auctioneerId;
  int userId;
  final void Function()? onTap;
  AuctioneerContainer({
    Key? key,
    required this.name,
    required this.auctioneerId,
    required this.userId,
    this.onTap,
  }) : super(key: key);

  @override
  State<AuctioneerContainer> createState() => _AuctioneerContainerState();
}

class _AuctioneerContainerState extends State<AuctioneerContainer> {
  final List<int> adminIds = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuctionCarsList(
                auctioneerId: widget.auctioneerId,
                userName: widget.name,
                userId: 1,
              ),
            ));
      },
      child: Container(
        height: 62,
        padding: const EdgeInsets.only(left: 10),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white30.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.name,
          style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 20),
        ),
      ),
    );
  }
}
