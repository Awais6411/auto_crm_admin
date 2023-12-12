import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final String text;
  bool? showCheckBox;
  int? admin_id;
  final int? status;
  final void Function()? onTap;
  CustomContainer({
    Key? key,
    required this.text,
    this.showCheckBox = false,
    this.onTap,
    this.admin_id,
    this.status,
  }) : super(key: key);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  final List<int> adminIds = [];

  void toggleCheckbox() {
    // setState(() {
    //   isChecked = !isChecked;
    // });

    if (widget.status == 1) {
      // Get.snackbar('Already Added', '',
      //     backgroundColor: Colors.grey.withOpacity(0.7),
      //     duration: Duration(seconds: 1));
    } else {
      setState(() {
        isChecked = !isChecked;
      });
    }
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () {});

    return GestureDetector(
      onTap: widget.onTap ?? toggleCheckbox,
      child: Container(
        height: 62,
        padding: const EdgeInsets.only(left: 10),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white30.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            widget.showCheckBox == true
                ? Checkbox(
                    value: widget.status == 0 ? isChecked : !isChecked,
                    onChanged: widget.status == 1
                        ? (value) {
                            // Get.snackbar('Already Added', '',
                            //     backgroundColor: Colors.grey.withOpacity(0.7),
                            //     duration: Duration(seconds: 1));
                          }
                        : (newValue) {
                            setState(() {
                              isChecked = newValue!;
                            });
                          },
                    activeColor: widget.status == 1
                        ? Colors.grey
                        : Colors.blue, // Gray out the checkbox
                    checkColor: Colors.white, // Change the checkmark color
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )
                : Container(),
            Text(
              widget.text,
              style:
                  TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
