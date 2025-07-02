import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentProfiles {
  final String? name;
  final String? surname;
  final String? className;
  final String? section;
  final String? rollNo;
  final String? type;
  final String? profileImageUrl;
  final String? joinedDate;
  final int? attendance;
  final String? homework;
  final int? performance;

  StudentProfiles({
    this.name,
    this.surname,
    this.className,
    this.section,
    this.rollNo,
    this.type,
    this.profileImageUrl,
    this.joinedDate,
    this.attendance,
    this.homework,
    this.performance,
  });

  factory StudentProfiles.fromJson(Map<String, dynamic> json) {
    return StudentProfiles(
      name: json['name'],
      surname: json['surname'],
      className: json['className'],
      section: json['section'],
      rollNo: json['rollNo'],
      type: json['type'],
      profileImageUrl: json['profileImageUrl'],
      joinedDate: json['joinedDate'],
      attendance: json['attendance'],
      homework: json['homework'],
      performance: json['performance'],
    );
  }
}

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  StudentProfiles? profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudentProfile();
  }

  Future<void> fetchStudentProfile() async {
    try {
      final response = await http.get(
        Uri.parse('https://yourapi.com/api/student/profile'), // Replace with real endpoint
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          profile = StudentProfiles.fromJson(data);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error loading profile: $e'),
      ));
    }
  }

  Widget infoCard(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.blue, fontSize: 12)),
      ],
    );
  }

  Widget buildInfoTile(String text, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.campaign, color: highlight ? Colors.blue : Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: highlight ? Colors.blue : Colors.black87),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridButton(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade50,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = profile;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("INTERSOFT ENGLISH MEDIUM\nSCHOOL BRANCH 2",
            style: TextStyle(fontSize: 14)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : data == null
          ? const Center(child: Text("No data found"))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blue.shade50,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: data.profileImageUrl != null
                        ? NetworkImage(data.profileImageUrl!)
                        : null,
                    child: data.profileImageUrl == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data.name ?? "-"} ${data.surname ?? ""}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text("Joined ${data.joinedDate ?? "-"}"),
                        const SizedBox(height: 4),
                        Text("Class - ${data.className ?? "-"}"),
                        Text("Section - ${data.section ?? "-"}"),
                        Text("Roll No - ${data.rollNo ?? "-"}"),
                        Text("Type - ${data.type ?? "-"}"),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Status Cards
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  infoCard("Attendance", "${data.attendance ?? '-'}%"),
                  infoCard("Homework", data.homework ?? "-"),
                  infoCard("Performance", "${data.performance ?? '-'}%"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Announcements
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Announcements",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text("See All",
                    style: TextStyle(
                        fontSize: 13, color: Colors.blueAccent)),
              ],
            ),
            const SizedBox(height: 12),
            buildInfoTile("Annual Drawing Competition results will be out by tomorrow 🔥"),
            buildInfoTile("🎉 Our School has completed: “20 Years”"),
            buildInfoTile(
              "📌 Admission 2025 Starts June 20th Onwards, enroll early to secure seats.",
              highlight: true,
            ),

            const SizedBox(height: 24),

            // Bottom Grid Menu
            GridView.count(
              crossAxisCount: size.width > 600 ? 4 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                buildGridButton("Assignment", Icons.assignment),
                buildGridButton("Time Table", Icons.calendar_month),
                buildGridButton("School Holiday", Icons.flag),
                buildGridButton("Result", Icons.emoji_events),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';

class StudentProfiles {
  final String? name;
  final String? surname;
  final String? className;
  final String? section;
  final String? rollNo;
  final String? type;
  final String? profileImageUrl;
  final String? joinedDate;
  final int? attendance;
  final String? homework;
  final int? performance;

  StudentProfiles({
    this.name,
    this.surname,
    this.className,
    this.section,
    this.rollNo,
    this.type,
    this.profileImageUrl,
    this.joinedDate,
    this.attendance,
    this.homework,
    this.performance,
  });
}

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  StudentProfiles? profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudentProfile();
  }

  Future<void> fetchStudentProfile() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate API delay

    // Simulated data; replace this with real API call and JSON parsing
    setState(() {
      profile = StudentProfiles(
        name: "Benjamin",
        surname: "Mosby",
        className: "VI",
        section: "A",
        rollNo: "6",
        type: "Day Scholar",
        profileImageUrl:
        "https://i.pravatar.cc/150?img=3", // Placeholder image
        joinedDate: "2 Years Ago",
        attendance: 70,
        homework: "03/21",
        performance: 80,
      );
      isLoading = false;
    });
  }

  Widget infoCard(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(color: Colors.blue, fontSize: 12),
        ),
      ],
    );
  }

  Widget buildInfoTile(String text, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.campaign, color: highlight ? Colors.blue : Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 13,
                  color: highlight ? Colors.blue : Colors.black87),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridButton(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade50,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = profile;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("INTERSOFT ENGLISH MEDIUM\nSCHOOL BRANCH 2",
            style: TextStyle(fontSize: 14)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blue.shade50,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: data?.profileImageUrl != null
                        ? NetworkImage(data!.profileImageUrl!)
                        : null,
                    child: data?.profileImageUrl == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data?.name ?? "-"} ${data?.surname ?? ""}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text("Joined ${data?.joinedDate ?? "-"}"),
                        const SizedBox(height: 4),
                        Text("Class - ${data?.className ?? "-"}"),
                        Text("Section - ${data?.section ?? "-"}"),
                        Text("Roll No - ${data?.rollNo ?? "-"}"),
                        Text("Type - ${data?.type ?? "-"}"),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Status Cards
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  infoCard("Attendance",
                      "${data?.attendance?.toString() ?? '-'}%"),
                  infoCard("Homework", data?.homework ?? "-"),
                  infoCard("Performance",
                      "${data?.performance?.toString() ?? '-'}%"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Announcements
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Announcements",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text("See All",
                    style: TextStyle(
                        fontSize: 13, color: Colors.blueAccent)),
              ],
            ),
            const SizedBox(height: 12),
            buildInfoTile(
                "Annual Drawing Competition results will be out by tomorrow 🔥"),
            buildInfoTile(
                "🎉 Our School have completed: “20 Years”"),
            buildInfoTile(
              "📌 Admission 2025 Starts June 20th Onwards, enroll early to secure seats.",
              highlight: true,
            ),

            const SizedBox(height: 24),

            // Bottom Grid Menu
            GridView.count(
              crossAxisCount: size.width > 600 ? 4 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                buildGridButton("Assignment", Icons.assignment),
                buildGridButton("Time Table", Icons.calendar_month),
                buildGridButton("School Holiday", Icons.flag),
                buildGridButton("Result", Icons.emoji_events),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

{
  "name": "Benjamin",
  "surname": "Mosby",
  "className": "VI",
  "section": "A",
  "rollNo": "6",
  "type": "Day Scholar",
  "profileImageUrl": "https://i.pravatar.cc/150?img=3",
  "joinedDate": "2 Years Ago",
  "attendance": 70,
  "homework": "03/21",
  "performance": 80
}

 */
