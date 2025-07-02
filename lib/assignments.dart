// import 'package:flutter/material.dart';
//
// class Assignments extends StatefulWidget {
//   const Assignments({super.key});
//
//   @override
//   State<Assignments> createState() => _AssignmentsState();
// }
//
// class _AssignmentsState extends State<Assignments> {
//   @override
//   Widget build(BuildContext context) {
//     var arrSubjects = ['English', 'Maths', 'Physics', 'Chemistry', 'Biology', 'Hindi', 'History'];
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Assignments', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: arrSubjects.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             elevation: 2,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Container(
//               height: screenHeight * 0.1, // ~10% of screen height
//               width: screenWidth * 0.9,
//               alignment: Alignment.center,
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 arrSubjects[index],
//                 style: TextStyle(
//                   fontSize: screenWidth * 0.05, // font size scales with screen width
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';

class Assignment{
  final String? subject;
  final logo;
  Assignment({
    this.subject,
    this.logo,
  });
  factory Assignment.fromJson(Map<String,dynamic>json){
    return Assignment(
      subject: json['subject'],
      logo: json['logo'],
    );
  }
}

class Assignments extends StatefulWidget {
  const Assignments({super.key});

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  List<dynamic> subjects = [];
  bool isLoading = true;
  bool useMockData1 = true;

  final Map<String, IconData> subjectIcons = {
    'Maths': Icons.calculate,
    'Physics': Icons.science,
    'Biology': Icons.biotech,
    'Chemistry': Icons.science ,
    'English': Icons.menu_book,
    'Hindi': Icons.language,
    'History': Icons.account_balance,
    'Geography': Icons.terrain,
    'Computer': Icons.computer,
  };

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    try {
      if(useMockData1){
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          subjects=[
            Assignment(
              subject: "Subject X",
              logo: Icons.science,
            ),
            Assignment(
              subject: "Subject X",
              logo: Icons.science,
            )
          ];
          isLoading=false;
        });
      }else{
        final response = await http.get(Uri.parse('https://your-api.com/subjects')); // Replace with your API
        if (response.statusCode == 200) {
          setState(() {
            subjects = json.decode(response.body);
            isLoading = false;
          });
        }
        else {
          throw Exception("Failed to load subjects");
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        subjects=[
          Assignment(subject: 'NULL',logo: 'NULL'),
          Assignment(subject: 'NULL',logo: 'NULL'),
        ];
      });
    }
  }

  Widget buildSubjectCard(String subject, double fontSize) {
    return GestureDetector(
      onTap: () {
        // 🔜 Add navigation to subject-wise assignment page here
        // Navigator.push(context, MaterialPageRoute(builder: (_) => SubjectAssignmentsPage(subject: subject)));
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(subjectIcons[subject] ?? Icons.book, size: 40, color: Colors.blue),
              const SizedBox(height: 8),
              Text(
                subject,
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          margin: const EdgeInsets.all(12),
          height: 100,
          width: double.infinity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.045;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: isLoading
            ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: 6,
          itemBuilder: (context, index) => buildShimmerCard(),
        )
            : subjects.isEmpty
            ? const Center(child: Text("No subjects found"))
            : GridView.builder(
          itemCount: subjects.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final subject = subjects[index]['subject'] ?? 'Unknown';
            return buildSubjectCard(subject, fontSize);
          },
        ),
      ),
    );
  }
}

// Your backend should return a JSON list like this:
// json
// [
// { "subject": "Maths" },
// { "subject": "Physics" },
// { "subject": "Biology" },
// { "subject": "History" }
// // ]
// What to Do Next
// Replace https://your-api.com/subjects with your real subject list API.
//
// When you're ready, inside the onTap: () { ... }, route to another page like SubjectAssignmentsPage(subject: subject).
