import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Student data model with nullable fields
class Student {
  final String? name;
  final String? classSection;
  final String? rollNumber;
  final String? aadhaar;
  final String? academicYear;
  final String? admissionClass;
  final String? oldAdmissionNumber;
  final String? dateOfAdmission;
  final String? dateOfBirth;
  final String? parentEmail;
  final String? motherName;
  final String? fatherName;
  final String? address;
  final String? imagePath;

  Student({
    this.name,
    this.classSection,
    this.rollNumber,
    this.aadhaar,
    this.academicYear,
    this.admissionClass,
    this.oldAdmissionNumber,
    this.dateOfAdmission,
    this.dateOfBirth,
    this.parentEmail,
    this.motherName,
    this.fatherName,
    this.address,
    this.imagePath,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      classSection: json['classSection'],
      rollNumber: json['rollNumber'],
      aadhaar: json['aadhaar'],
      academicYear: json['academicYear'],
      admissionClass: json['admissionClass'],
      oldAdmissionNumber: json['oldAdmissionNumber'],
      dateOfAdmission: json['dateOfAdmission'],
      dateOfBirth: json['dateOfBirth'],
      parentEmail: json['parentEmail'],
      motherName: json['motherName'],
      fatherName: json['fatherName'],
      address: json['address'],
      imagePath: json['imagePath'],
    );
  }
}

// Fetch API data
Future<Student> fetchStudentProfile() async {
  final response = await http.get(Uri.parse('https://yourapi.com/student/profile')); // Replace with your endpoint

  if (response.statusCode == 200) {
    return Student.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load student profile');
  }
}

// Student Profile Page
class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  String safe(String? value) => value ?? 'NULL';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Student>(
      future: fetchStudentProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
        } else if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: Text('No data found')));
        } else {
          final student = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile', style: TextStyle(fontSize: 30, color: Colors.white)),
              backgroundColor: Colors.blue,
              centerTitle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: (student.imagePath != null && student.imagePath!.startsWith('http'))
                                  ? Image.network(student.imagePath!, fit: BoxFit.cover)
                                  : Image.asset(student.imagePath ?? 'assets/default.png', fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    safe(student.name),
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${safe(student.classSection)} | ${safe(student.rollNumber)}',
                                    style: const TextStyle(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const Column(
                              children: [
                                SizedBox(height: 10),
                                Icon(Icons.camera_alt_outlined),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildInfoRow('Aadhaar Number', safe(student.aadhaar), 'Academic Year', safe(student.academicYear)),
                    _buildInfoRow('Admission Class', safe(student.admissionClass), 'Old Admission Number', safe(student.oldAdmissionNumber)),
                    _buildInfoRow('Date of Admission', safe(student.dateOfAdmission), 'Date of Birth', safe(student.dateOfBirth)),
                    const SizedBox(height: 20),
                    _buildSingleInfo('Parent Mail ID', safe(student.parentEmail)),
                    _buildSingleInfo('Mother\'s Name', safe(student.motherName)),
                    _buildSingleInfo('Father\'s Name', safe(student.fatherName)),
                    _buildSingleInfo('Permanent Address', safe(student.address)),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildInfoRow(String label1, String value1, String label2, String value2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label1, style: const TextStyle(color: Colors.grey)),
              Text(value1, style: const TextStyle(fontSize: 18)),
              Container(height: 1, width: 180, color: Colors.grey),
            ],
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label2, style: const TextStyle(color: Colors.grey)),
              Text(value2, style: const TextStyle(fontSize: 18)),
              Container(height: 1, width: 150, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSingleInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 18)),
          Container(height: 1, width: 350, color: Colors.grey),
        ],
      ),
    );
  }
}
