import 'package:auto_crm_admin/views/common/widgets/custome_menu_drawer.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/month_view.dart';

class ChooseMonthScreen extends StatefulWidget {
  const ChooseMonthScreen({super.key});

  @override
  State<ChooseMonthScreen> createState() => _ChooseMonthScreenState();
}

class _ChooseMonthScreenState extends State<ChooseMonthScreen> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 8, 99, 155),
        title: const Text(
          "Opportunities",
          style: TextStyle(fontSize: 24),
        ),
      ),
      drawer: const CustomMenuDrawer(),
      body: Container(
        alignment: Alignment.topCenter,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            // color: Colors.red,
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 167, 217, 234),
            Color.fromARGB(255, 6, 137, 166)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            CalendarPage(),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
