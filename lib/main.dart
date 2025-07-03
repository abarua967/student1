import 'package:flutter/material.dart';
import 'package:student1/feeds.dart';
import 'package:student1/notifications_page.dart';
import 'package:student1/calendar.dart';
import 'package:student1/fees.dart';
import 'package:student1/attendance.dart';
import 'package:student1/profile.dart';
import 'package:student1/time-table.dart';
import 'package:student1/assignments.dart';
import 'package:student1/results.dart';
import 'package:student1/digital_locker.dart';
import 'package:student1/profile2.dart';
import 'package:student1/attendance2.dart';
import 'package:student1/Events.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner:false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> menuItems = [
    {'title':'Student Profile','imagePath':'assets/images/student-profile.png'},
    {'title':'Student Profile 2','imagePath':'assets/images/student-profile.png'},
    {'title': 'View Attendance', 'imagePath': 'assets/images/immigration.png'},
    {'title': 'Attendance2','imagePath':'assets/images/immigration.png'},
    {'title': 'Home Work', 'imagePath': 'assets/images/homework.png'},
    {'title': 'Academic Result','imagePath': 'assets/images/paper-document.png'},
    {'title': 'Leave Apply','imagePath': 'assets/images/health-check.png'},
    {'title': 'Feeds','imagePath': 'assets/images/newspaper.png'},
    {'title': 'School Fees','imagePath': 'assets/images/fees.png'},
    {'title': 'Class Timetable','imagePath': 'assets/images/administration.png'},
    {'title': 'Inquiry','imagePath': 'assets/images/inquiry.png'},
    {'title': 'Digital Locker','imagePath':'assets/images/digital.png'},
    {'title': 'Events','imagePath':'assets/images/newspaper.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Step 2
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[800]),
              child: Text('P.J.S. Mission School', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Calendar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          // Header background
          Container(
            height: 230,
            decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(200))
            ),
          ),

          // Hamburger Menu + Notification Icon
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer(); // Step 3
              },
              child: Icon(Icons.menu, color: Colors.white, size: 28),
            ),
          ),

          Positioned(
              top: 40,
              right: 16,
              child: GestureDetector(
                onTap:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationsPage()),
                  );
                },
                child: Icon(Icons.notifications, color: Colors.white, size: 26),
              )
          ),

          // Content
          Column(
            children: [
              SizedBox(height: 60),
              CircleAvatar(
                radius: 20,
              ),
              SizedBox(height: 10),
              Text(
                'P.J.S. MISSION ENGLISH MEDIUM\n(BRANCH 2)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 90),

              // Grid Menu
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                    itemCount: menuItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            if(item['title']=='Student Profile'){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder:(context)=> const StudentProfile()),
                              );
                            }
                            else if (item['title'] == 'Student Profile 2') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const StudentProfilePage()),
                              );
                            }
                            else if (item['title'] == 'School Fees') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const FeeDetailsPage()),
                              );
                            }
                            else if(item['title']=='View Attendance'){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AttendancePage()),
                              );
                            }
                            else if(item['title']=='Attendance2'){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AttendanceCalendarPage()),
                              );
                            }
                            else if(item['title']=='Feeds'){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const NoticeBoard()),
                              );
                            }
                            else if(item['title']=='Class Timetable'){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const TimetablePage()),
                              );
                            }
                            else if(item['title']=='Home Work'){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Assignments()),
                              );
                            }
                            else if(item['title']=='Academic Result'){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ResultsPage()),
                              );
                            }
                            else if(item['title']=='Digital Locker'){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const DocumentsPage()),
                              );
                            }
                            else if(item['title']=='Events'){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  EventsPage()),
                              );
                            }
                            // You can add other conditions here if you want to navigate to other pages later.
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                item['imagePath'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
