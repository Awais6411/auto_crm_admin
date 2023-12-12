import 'package:auto_crm_admin/controllers/admin/admin_provider.dart';
import 'package:auto_crm_admin/views/ui/oppurtunities/users_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDate;
  int? _weekId;
  DateTime _focusedDay = DateTime.now();

  String? _weekRange;

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
      _focusedDay = selectedDay;

      // Calculate the week ID for the selected date
      _weekId = getWeekNumber(selectedDay);

      // Calculate the week range
      final startOfWeek =
          selectedDay.subtract(Duration(days: selectedDay.weekday - 1));
      final endOfWeek = selectedDay
          .add(Duration(days: DateTime.daysPerWeek - selectedDay.weekday));

      // Create a week range string
      _weekRange =
          '${DateFormat('d').format(startOfWeek)}-${DateFormat('d').format(endOfWeek)}';
    });
  }

  int getWeekNumber(DateTime date) {
    // Calculate the week number for the given date
    const daysInWeek = DateTime.daysPerWeek;
    final dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + daysInWeek) / daysInWeek).ceil();
  }

  bool _isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year &&
        dayA.month == dayB.month &&
        dayA.day == dayB.day;
  }

  @override
  Widget build(BuildContext context) {
    var adminProvider = Provider.of<AdminNotifier>(context);
    return Column(
      children: <Widget>[
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          weekendDays: const [DateTime.sunday],
          calendarStyle: CalendarStyle(
              rowDecoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 95, 93, 93),
              width: 1.0,
            ),
          )),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _onDaySelected(selectedDay, focusedDay);
              var selectedDate = DateFormat('MMMM')
                  .format(_selectedDate ?? DateTime.now())
                  .toString();
              adminProvider.selectedDate = "$selectedDate  $_weekRange";
              adminProvider.weekId = _weekId.toString();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UsersList(),
                ),
              );
            });
          },
          headerStyle: const HeaderStyle(
            formatButtonVisible: false, // Hide the format button
          ),
          onFormatChanged: (format) {},
        ),
      ],
    );
  }
}
