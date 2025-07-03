import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import'package:student1/time-table_model.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage>
    with SingleTickerProviderStateMixin {
  final bool useApi2 = false;
  late TabController _tabController;
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  Color getDayColor(String day) {
    switch (day) {
      case 'Mon':
        return Colors.white;
      case 'Tue':
        return Colors.white;
      case 'Wed':
        return Colors.white;
      case 'Thu':
        return Colors.white;
      case 'Fri':
        return Colors.white;
      case 'Sat':
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  Map<String, List<Map<String, String>>> timetable = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: days.length, vsync: this);
    fetchTimetable();
  }

  Future<void> fetchTimetable() async {
    try {
      if (useApi2) {
        final response =
        await http.get(Uri.parse('https://your-api.com/timetable'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          setState(() {
            timetable = {
              for (var day in days)
                day: (data[day] as List<dynamic>? ?? [])
                    .map((item) => PeriodModel.fromJson(item).toMap())
                    .toList()
            };
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load timetable');
        }
      }
      else {
        setState(() {
          timetable = {
            "Mon": [
              {
                "subject": "Maths",
                "time": "08:15am - 09:00am",
                "teacher": "John Doe"
              },
              {
                "subject": "Science",
                "time": "09:00am - 09:45am",
                "teacher": "Alice Smith"
              },
              {
                "subject": "Science",
                "time": "09:00am - 09:45am",
                "teacher": "Alice Smith"
              },
              {
                "subject": "Science",
                "time": "09:00am - 09:45am",
                "teacher": "Alice Smith"
              },
              {
                "subject": "Science",
                "time": "09:00am - 09:45am",
                "teacher": "Alice Smith"
              },
              {
                "subject": "Science",
                "time": "09:00am - 09:45am",
                "teacher": "Alice Smith"
              },
            ],
            "Tue": [
              {
                "subject": "English",
                "time": "08:15am - 09:00am",
                "teacher": "Robert Miles"
              },
              {
                "subject": "History",
                "time": "09:00am - 09:45am",
                "teacher": "Lily White"
              }
            ],
            "Wed": [
              {
                "subject": "Geography",
                "time": "08:15am - 09:00am",
                "teacher": "David Stone"
              },
              {
                "subject": "Science",
                "time": "09:00am - 09:45am",
                "teacher": "Alice Smith"
              }
            ],
            "Thu": [
              {
                "subject": "Maths",
                "time": "08:15am - 09:00am",
                "teacher": "John Doe"
              },
              {
                "subject": "English",
                "time": "09:00am - 09:45am",
                "teacher": "Robert Miles"
              }
            ],
            "Fri": [
              {
                "subject": "Physics",
                "time": "08:15am - 09:00am",
                "teacher": "Albert Newton"
              },
              {
                "subject": "Chemistry",
                "time": "09:00am - 09:45am",
                "teacher": "Marie Curie"
              }
            ],
            "Sat": [
              {
                "subject": "Arts",
                "time": "08:15am - 09:00am",
                "teacher": "Emma Stone"
              },
              {
                "subject": "PE",
                "time": "09:00am - 09:45am",
                "teacher": "Coach Carter"
              }
            ],
          };
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Table', style: TextStyle(fontSize:20,color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        leading: const BackButton(color: Colors.white),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: days.map((day) {
            return Tab(
              child: Text(
                day,
                style: TextStyle(
                  color: getDayColor(day),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),

      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
        controller: _tabController,
        children: days.map((day) {
          final periods = timetable[day] ?? [];
          if (periods.isEmpty) {
            return const Center(child: Text('No periods scheduled.'));
          }
          return ListView.builder(
            itemCount: periods.length + // actual periods
                (periods.length > 3 ? 1 : 0) + // short break after 3rd
                (periods.length > 5 ? 1 : 0),  // lunch break after 5th
            itemBuilder: (context, index) {
              int originalIndex = index;
              bool isShortBreak = false;
              bool isLunchBreak = false;

              // Insert short break after 3rd period
              if (periods.length > 3 && index == 3) {
                isShortBreak = true;
              }

              // Insert lunch break after 5th period (index 5 plus 1 if short break is added)
              if (periods.length > 5 &&
                  index == 5 + (periods.length > 3 ? 1 : 0)) {
                isLunchBreak = true;
              }

              if (isShortBreak) {
                return const Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.orangeAccent,
                  child: ListTile(
                    leading: Icon(Icons.coffee),
                    title: Text("Short Break"),
                    subtitle: Text("10:30-10:45"),
                  ),
                );
              }

              if (isLunchBreak) {
                return const Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.greenAccent,
                  child: ListTile(
                    leading: Icon(Icons.lunch_dining),
                    title: Text("Lunch Break"),
                    subtitle: Text("12:15-12:45"),
                  ),
                );
              }

              // Adjust index if we've already inserted breaks
              int breakOffset = 0;
              if (periods.length > 3 && index > 3) breakOffset++;
              if (periods.length > 5 && index > 5 + breakOffset) breakOffset++;

              final period = periods[index - breakOffset];
              return Card(
                margin: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.book),
                      title: Text(period['subject'] ?? ''),
                      subtitle: Text('${period['time']}\n${period['teacher']}'),
                      isThreeLine: true,
                    ),
                    Positioned(
                      bottom: 8,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Period ${index - breakOffset + 1}', // Period number
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              );

            },
          );

        }).toList(),
      ),
    );
  }
}
