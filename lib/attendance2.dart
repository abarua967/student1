import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AttendanceCalendarPage extends StatefulWidget {
  const AttendanceCalendarPage({super.key});

  @override
  State<AttendanceCalendarPage> createState() =>
      _AttendanceCalendarPageState();
}

class _AttendanceCalendarPageState extends State<AttendanceCalendarPage> {
  bool isAttendanceView = true;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  DateTime get academicYearStart =>
      DateTime(DateTime.now().month >= 6 ? DateTime.now().year : DateTime.now().year - 1, 6, 1);
  DateTime get academicYearEnd =>
      DateTime(DateTime.now().month >= 6 ? DateTime.now().year + 1 : DateTime.now().year, 5, 31);

  final Map<DateTime, String> attendanceMap = {
    DateTime(2023, 11, 6): 'Present',
    DateTime(2023, 11, 7): 'Present',
    DateTime(2023, 11, 8): 'Absent',
    DateTime(2023, 11, 14): 'Holiday',
    DateTime(2023, 11, 15): 'Holiday',
    DateTime(2023, 11, 16): 'Holiday',
    DateTime(2023, 11, 17): 'Leave',
    DateTime(2023, 11, 23): 'Absent',
    DateTime(2023, 11, 30): 'Present',
  };

  final List<Map<String, String>> holidays = [
    {'title': 'Diwali', 'date': '2023-11-14', 'day': 'Tuesday'},
    {'title': 'Govardhan Puja', 'date': '2023-11-15', 'day': 'Wednesday'},
    {'title': 'Bhaiya Dooj', 'date': '2023-11-16', 'day': 'Thursday'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => setState(() => isAttendanceView = true),
            child: Text("ATTENDANCE", style: TextStyle(color: isAttendanceView ? Colors.white : Colors.white70)),
          ),
          TextButton(
            onPressed: () => setState(() => isAttendanceView = false),
            child: Text("HOLIDAY", style: TextStyle(color: !isAttendanceView ? Colors.white : Colors.white70)),
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: academicYearStart,
            lastDay: academicYearEnd,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: CalendarFormat.month,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final key = DateTime(day.year, day.month, day.day);
                final status = attendanceMap[key];

                Color? color;
                if (isAttendanceView) {
                  if (status == 'Present') color = Colors.green;
                  else if (status == 'Absent') color = Colors.red;
                  else if (status == 'Leave') color = Colors.blue;
                } else {
                  if (status == 'Holiday') color = Colors.purple;
                }

                if (color != null) {
                  return Center(
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }

                return Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          if (!isAttendanceView) _buildHolidayList(),
          if (isAttendanceView) _buildAttendanceSummary(),
        ],
      ),
    );
  }

  Widget _buildHolidayList() {
    return Expanded(
      child: ListView.builder(
        itemCount: holidays.length,
        itemBuilder: (context, index) {
          final holiday = holidays[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Card(
              child: ListTile(
                title: Text(holiday['title']!),
                subtitle: Text(DateFormat("d MMMM, y").format(DateTime.parse(holiday['date']!))),
                trailing: Text(holiday['day']!),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAttendanceSummary() {
    int present = attendanceMap.values.where((v) => v == 'Present').length;
    int absent = attendanceMap.values.where((v) => v == 'Absent').length;
    int leave = attendanceMap.values.where((v) => v == 'Leave').length;
    int holiday = attendanceMap.values.where((v) => v == 'Holiday').length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      child: Column(
        children: [
          _buildLegendRow("Absent", Colors.red, absent),
          const SizedBox(height: 8),
          _buildLegendRow("Classes Attended", Colors.green, present),
          const SizedBox(height: 8),
          _buildLegendRow("Leave", Colors.blue, leave),
          const SizedBox(height: 8),
          _buildLegendRow("Festival & Holidays", Colors.purple, holiday),
          const SizedBox(height: 16),

        ],
      ),
    );
  }

  Widget _buildLegendRow(String label, Color color, int count) {
    return Row(
      children: [
        Container(width: 20, height: 20, color: color),
        const SizedBox(width: 10),
        Expanded(child: Text(label)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            count.toString().padLeft(2, '0'),
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
