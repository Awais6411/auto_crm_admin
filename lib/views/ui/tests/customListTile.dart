/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controllers/cars/cars_provider.dart';

class CustomTile extends StatefulWidget {
  final title;
  final subTitle;
  final imageUrl;
  final index;
  final status;

  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  const CustomTile({
    super.key,
    this.title,
    this.subTitle,
    this.onEditPressed,
    this.onDeletePressed,
    this.index,
    this.imageUrl,
    this.status,
  });

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  List<Map<String, dynamic>> mapObject = [
    {'status': true, '2018 Ford F-150': '', '': ''},
    {'status': false, '2019 Mercedes S-Class': '', '': ''},
    {'status': false, '2022 Porsche Panamera': '', '': ''},
    {'status': true, '2023 Audi A-4': '', '': ''},
  ];

  bool isChecked = false;
  bool makeEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChecked = widget.status == 0 ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<CarsNotifier>(context, listen: false);

    return Container(
      child: ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          leading: Checkbox(
            value: isChecked ? true : false,
            onChanged: widget.status == 1
                ? (value) {
                    Get.snackbar('Already Added', 'Can\'t be reselected',
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.grey.withOpacity(0.8));

                    print("already called");
                    // mapObject[widget.index]['status'] = false;
                  }
                : (value) {
                    setState(() {
                      isChecked = value!;
                      if (isChecked) {
                        userProvider.addCarId(widget.index);
                      }
                      if (!isChecked) {
                        // userProvider.removeCarId(widget.index);
                      }
                      print('CheckBox Called');
                      print('Added Id${userProvider.carIdsList}');
                    });
                  },
            activeColor: widget.status == 1
                ? Colors.grey
                : Colors.blue, // Gray out the checkbox
            checkColor: Colors.white, // Change the checkmark color
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(widget.subTitle),
          trailing: Container(
            height: 100,
            width: 70,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 234, 234),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.network(
              'http://192.168.0.104:5000/images/${widget.imageUrl}',
              height: 70,
              width: 40,
              // fit: BoxFit.fitWidth,
            ),
          )),
    );
  }
}
 */