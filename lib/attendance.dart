import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendancePage extends StatefulWidget {
  final bool isAdmin; // true for admin, false for student

  const AttendancePage({super.key, this.isAdmin = false});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Map to store attendance: true = Present, false = Absent
  Map<DateTime, bool> attendanceMap = {
    DateTime.utc(2025, 6, 10): true,
    DateTime.utc(2025, 6, 11): false,
    DateTime.utc(2025, 6, 13): true,
  };

  // Helper to normalize date (remove time component)
  DateTime getDateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance',style: TextStyle(fontSize: 20,color:Colors.white),),
        leading: const BackButton(color: Colors.white,),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2025, 1, 1),
          lastDay: DateTime.utc(2027, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          calendarFormat: CalendarFormat.month,
          onDaySelected: (selectedDay, focusedDay) {
            if (widget.isAdmin) {
              setState(() {
                final key = getDateOnly(selectedDay);
                // Toggle between present/absent
                if (attendanceMap.containsKey(key)) {
                  attendanceMap[key] = !attendanceMap[key]!;
                } else {
                  attendanceMap[key] = true;
                }
              });
            }
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              final key = getDateOnly(day);
              if (attendanceMap.containsKey(key)) {
                final isPresent = attendanceMap[key]!;
                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isPresent ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }
              return null;
            },
            todayBuilder: (context, day, focusedDay) {
              final key = getDateOnly(day);
              final isPresent = attendanceMap[key];

              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isPresent == null
                      ? Colors.blue
                      : isPresent
                      ? Colors.green
                      : Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${day.day}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
