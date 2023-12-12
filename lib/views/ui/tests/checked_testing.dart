import 'package:flutter/material.dart';

class Car {
  final String name;
  bool isChecked;

  Car(this.name, this.isChecked);
}

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  List<Car> cars = [
    Car('Car 1', true), // Checked and disabled
    Car('Car 2', false), // Not checked and enabled
    Car('Car 3', true), // Checked and disabled
    // Add more cars here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index) {
            final car = cars[index];
            return ListTile(
              title: Text(car.name),
              leading: Checkbox(value: car.isChecked, onChanged: null
                  // (value) {
                  //   setState(() {
                  //     car.isChecked = value!;
                  //   });
                  // }, // Disable the checkbox
                  ),
            );
          },
        ),
      ),
    );
  }
}
