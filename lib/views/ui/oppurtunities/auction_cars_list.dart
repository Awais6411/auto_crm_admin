import 'package:auto_crm_admin/views/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/admin/admin_provider.dart';
import '../../common/widgets/oppur_cardview.dart';

import 'oppur_vehicle_details.dart';

class AuctionCarsList extends StatefulWidget {
  int auctioneerId;
  int? userId;
  final String? userName;
  AuctionCarsList({
    Key? key,
    required this.auctioneerId,
    this.userId,
    this.userName,
  }) : super(key: key);

  @override
  State<AuctionCarsList> createState() => _AuctionCarsListState();
}

class _AuctionCarsListState extends State<AuctionCarsList> {
  final ScrollController scrollController = ScrollController();

  var userId;
  @override
  void initState() {
    super.initState();
    _loadSharedPreferencesData();
  }

  Future<void> _loadSharedPreferencesData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? result = prefs.getInt("userId") ?? 0;
    setState(() {
      userId = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminNotifier>(
      builder: (context, auctioneerNotifier, child) {
        auctioneerNotifier.getAllCarsByAuctioneerId(
            widget.auctioneerId, widget.userId ?? 0, auctioneerNotifier.weekId);
        return Scaffold(
            appBar: customAppBar(
                onTap: () {
                  Navigator.pop(context);
                },
                title:
                    "${widget.userName}  ${auctioneerNotifier.selectedDate}"),
            body: FutureBuilder(
              future: auctioneerNotifier.allAuctioneerCarsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  var carList = snapshot.data;
                  return Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 167, 217, 234),
                        Color.fromARGB(255, 6, 137, 166)
                      ], // Replace with your desired colors
                      begin: Alignment.topLeft, // Adjust the starting point
                      end: Alignment.bottomRight, // Adjust the ending point
                    )),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: ListView.builder(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 8, bottom: 8),
                              itemCount: carList!.length,
                              controller: scrollController,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return AuctionCarCardView(
                                  car_id: carList[index].vehicleId ?? 1,
                                  year: carList[index].year,
                                  make: carList[index].make,
                                  color: carList[index].color,
                                  model: carList[index].model,
                                  details: carList[index].details,
                                  auctionName: carList[index].auctionName,
                                  laneNumber: carList[index].laneNumber,
                                  imageUrl:
                                      carList[index].imageUrl ?? 'preview.png',
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OppurtCarDetails(
                                                    vehicleId: carList[index]
                                                        .vehicleId,
                                                    color: carList[index].color,
                                                    details: carList[
                                                            index]
                                                        .details,
                                                    imageUrl: carList[
                                                                index]
                                                            .imageUrl ??
                                                        'preview.png',
                                                    salePrice: 1700,
                                                    soldStatus: 'Not Sold',
                                                    startingBid: 1500,
                                                    vin:
                                                        carList[index].vin ??
                                                            'Null',
                                                    year: carList[index].year,
                                                    make: carList[index].make,
                                                    model:
                                                        carList[index].model)));
                                  },
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
                }
              },
            ));
      },
    );
  }
}
