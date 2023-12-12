import 'dart:io';

import 'package:auto_crm_admin/controllers/admin/admin_provider.dart';
import 'package:auto_crm_admin/views/common/widgets/custom_appbar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/config.dart';
import '../../common/widgets/custom_color_dropdown.dart';
import '../../common/widgets/inputfield_withborder.dart';
import '../../common/widgets/price_input.dart';
import '../../common/widgets/reuseable_elevated_btn.dart';

class ColorOption {
  final String colorName;
  final Color color;

  ColorOption(this.colorName, this.color);
}

class OppurtCarDetails extends StatefulWidget {
  bool showAppBar = true;
  bool? isEdit;
  int? vehicleId;
  final String vin;
  final String year;
  final String make;
  final String model;
  final String details;
  final String color;
  final int startingBid;
  final int salePrice;
  final String soldStatus;
  String imageUrl;
  OppurtCarDetails({
    Key? key,
    this.showAppBar = true,
    this.isEdit = false,
    this.vehicleId,
    required this.vin,
    required this.details,
    required this.color,
    required this.startingBid,
    required this.salePrice,
    required this.soldStatus,
    required this.imageUrl,
    required this.year,
    required this.make,
    required this.model,
  }) : super(key: key);

  @override
  State<OppurtCarDetails> createState() => _OppurtCarDetailsState();
}

class _OppurtCarDetailsState extends State<OppurtCarDetails> {
  List<File?> imageUrl = [];
  List<File?> selectedImage = []; // This will hold the selected image file
  bool showspinner = false;
  String? year;
  String? make;
  String? color;

  TextEditingController salePriceController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController reserveController = TextEditingController();
  TextEditingController vinController = TextEditingController();
  TextEditingController anoucementsController = TextEditingController();
  TextEditingController soldStatusController = TextEditingController();
  ScrollController scrollController = ScrollController();
  var userId;
  var vehicleId;
  var title = 'New Vehicle';
  var buttonText = 'Save';
  bool isEdit = false;
  String selectedColor = 'Red';
// The list of items for the dropdown
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  // The currently selected item
  String selectedItem = 'Item 1'; // Set your initial value here

  final List<ColorOption> colorOptions = [
    ColorOption('Yellow', Colors.yellow),
    ColorOption('Green', Colors.green),
    ColorOption('Red', Colors.red),
  ];
  bool firstTime = true;
  @override
  void initState() {
    super.initState();
    _loadSharedPreferencesData();
  }

  Future<void> _loadSharedPreferencesData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? result = prefs.getInt("userId") ?? 0;

    setState(() {
      userId = result ?? 0;
      vehicleId = widget.vehicleId ?? 0;
      isEdit = widget.isEdit ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
            onTap: () {
              Navigator.pop(context);
            },
            title: "${widget.year} ${widget.make} ${widget.model}"),
        body: Consumer<AdminNotifier>(
          builder: (context, carsNotifier, child) {
            if (firstTime) {
              carsNotifier.getCarDetailsByIdTesting(widget.vehicleId!);
            }
            return Stack(
              children: [
                Positioned(
                    child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 167, 217, 234),
                            Color.fromARGB(255, 6, 137, 166)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )),
                        child: FutureBuilder(
                          future: carsNotifier.carDetailsTesting,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('${snapshot.error}'),
                              );
                            } else {
                              var data = snapshot.data;
                              // print(data!.anoucements);
                              if (firstTime) {
                                anoucementsController.text =
                                    data!.anoucements ?? 'None';
                                reserveController.text =
                                    (data.reserve ?? 1500).toString();
                                soldStatusController.text =
                                    data.saleStatus ?? 'Not Sold';
                                salePriceController.text =
                                    (data.soldPrice ?? "0.0").toString();
                                conditionController.text =
                                    data.conditionLight ?? "";
                                vinController.text = data.vin ?? "AFA887AH";
                                firstTime = false;
                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: double.maxFinite,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 30),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        controller: scrollController,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 170,
                                              width: 220,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "${Config.SERVER_IMAGES_URL}/${data!.imageUrl}")),
                                                  border: Border.all(
                                                      width: 2,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              38,
                                                              98,
                                                              147))),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    top: 5),
                                                child: InputFieldWithBorder(
                                                  enabled: false,
                                                  // hintText: "VIN:${data.vin}",
                                                  hintText: "",
                                                  prefixText: "Vin: ",
                                                  controller: vinController,
                                                  paddingEnabled: false,
                                                )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                height:
                                                    50, // Set a custom height
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // Set the corner radius
                                                  color: Colors.white.withOpacity(
                                                      0.8), // Set the background color
                                                ),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  value: selectedColor,
                                                  onChanged: null,
                                                  // onChanged: (newValue) {
                                                  //   setState(() {
                                                  //     selectedColor = newValue!;
                                                  //   });
                                                  // },
                                                  onTap: () {},
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.7)),
                                                  decoration:
                                                      const InputDecoration(
                                                          border: InputBorder
                                                              .none, // Remove the underline
                                                          prefixText:
                                                              "Condition Light: "),
                                                  items: colorOptions.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (ColorOption option) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: option.colorName,
                                                      child: Row(
                                                        children: <Widget>[
                                                          const Text(''),
                                                          Container(
                                                            width: 20,
                                                            height: 20,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  option.color,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16, right: 16),
                                                child: InputFieldWithBorder(
                                                  hintText: "",
                                                  prefixText: "Annoucements: ",
                                                  maxlines: 4,
                                                  height: 120,
                                                  controller:
                                                      anoucementsController,
                                                  paddingEnabled: false,
                                                  enabled: false,
                                                )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 16,
                                                  right: 16,
                                                ),
                                                child: PriceInputWidget(
                                                  controller: reserveController,
                                                  hintText: "Reserve",
                                                  prefixText: "Reserve: ",
                                                  enabled: false,
                                                )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16, right: 16),
                                                child: InputFieldWithBorder(
                                                  hintText: "",
                                                  prefixText: 'Sale Status: ',
                                                  controller:
                                                      soldStatusController,
                                                  suffixIcon: Icon(
                                                    Icons.edit,
                                                    color: const Color.fromARGB(
                                                            255, 50, 95, 52)
                                                        .withOpacity(0.8),
                                                    size: 30,
                                                  ),
                                                  enabled: true,
                                                  paddingEnabled: false,
                                                )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                              ),
                                              child: PriceInputWidget(
                                                controller: salePriceController,
                                                hintText: '',
                                                prefixText: 'Sale Price: ',
                                                enabled: true,
                                                suffixIcon: Icon(
                                                  Icons.edit,
                                                  color: const Color.fromARGB(
                                                          255, 50, 95, 52)
                                                      .withOpacity(0.8),
                                                  size: 30,
                                                ),
                                              ),
                                            ),

                                            // Container to add background color and border
                                            Container(
                                              margin: EdgeInsets.all(15),
                                              width: 300,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: DropdownButton(
                                                // Set the value to the initially selected item
                                                value: selectedItem,
                                                // Set the list of items
                                                items: items.map((String item) {
                                                  return DropdownMenuItem(
                                                    value: item,
                                                    child: Text(item),
                                                  );
                                                }).toList(),
                                                // Define the onChanged callback to update the selected item
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedItem = newValue!;
                                                  });
                                                },
                                              ),
                                            ),

                                            Container(
                                              margin: EdgeInsets.all(15),
                                              width: 300,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: DropdownButton(
                                                // Set the value to the initially selected item
                                                value: selectedItem,
                                                // Set the list of items
                                                items: items.map((String item) {
                                                  return DropdownMenuItem(
                                                    value: item,
                                                    child: Text(item),
                                                  );
                                                }).toList(),
                                                // Define the onChanged callback to update the selected item
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedItem = newValue!;
                                                  });
                                                },
                                              ),
                                            ),

                                            const SizedBox(
                                              height: 30,
                                            ),
                                            ReuseAbleElevatedButton(
                                              onPressed: carsNotifier.isLoading
                                                  ? () {}
                                                  : () {
                                                      carsNotifier.isLoading =
                                                          true;
                                                      var vehicleId =
                                                          widget.vehicleId;
                                                      var soldStatus =
                                                          soldStatusController
                                                              .text
                                                              .trim();
                                                      var salePrice =
                                                          salePriceController
                                                              .text
                                                              .trim();
                                                      carsNotifier
                                                          .updateCarStatus(
                                                              vehicleId!,
                                                              // 18,
                                                              soldStatus,
                                                              salePrice,
                                                              context);
                                                    },
                                              width: 280,
                                              height: 45,
                                              text: "Update",
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              );
                            }
                          },
                        ))),
                if (carsNotifier.isLoading)
                  Positioned(
                      child: Container(
                    color: Colors.transparent.withOpacity(0.6),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ))
              ],
            );
          },
        ));
  }
}
