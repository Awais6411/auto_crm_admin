import 'package:flutter/material.dart';

class DropdownItem {
  final Color color;
  final String text;

  DropdownItem({required this.color, required this.text});
}

List<DropdownItem> dropdownItems = [
  // DropdownItem(color: Colors.red, text: "Red"),
  DropdownItem(color: Colors.red, text: "Red"),
  DropdownItem(color: Colors.blue, text: "Blue"),
  DropdownItem(color: Colors.green, text: "Green"),
  DropdownItem(color: Colors.yellow, text: "Yellow"),
  DropdownItem(color: Colors.black, text: "Black"),
  // Add more items as needed
];

class CustomColorDropdown extends StatefulWidget {
  final List<DropdownItem> items;
  final ValueChanged<DropdownItem?> onChanged;
  final DropdownItem? value;

  CustomColorDropdown({
    required this.items,
    required this.onChanged,
    required this.value,
  });

  @override
  _CustomColorDropdownState createState() => _CustomColorDropdownState();
}

class _CustomColorDropdownState extends State<CustomColorDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<DropdownItem>(
      hint: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Color",
          style: TextStyle(color: Colors.black.withOpacity(0.5)),
        ),
      ),
      value: widget.value,

      underline: Container(),
      onChanged: widget.onChanged, // Remove the underline
      items: widget.items.map((DropdownItem item) {
        setState(() {
          // print("${provider.color}");
        });
        return DropdownMenuItem<DropdownItem>(
          value: item,
          child: SizedBox(
            height: 120,
            width: 270,
            child: ListTile(
              trailing: CircleAvatar(
                backgroundColor: item.color,
                radius: 12.0,
              ),
              title: Text(item.text),
            ),
          ),
          // child: Text('Drop down'),
        );
      }).toList(),
    );
  }
}
