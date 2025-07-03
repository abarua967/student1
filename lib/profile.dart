import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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

Future<Student> fetchStudentProfile() async {
  const String apiUrl = '';

  if (apiUrl.isEmpty) {
    return Student(
      name: 'Abhishek Sharma',
      classSection: '10-B',
      rollNumber: '12',
      aadhaar: '1234-5678-9012',
      academicYear: '2024-2025',
      admissionClass: 'Nursery',
      oldAdmissionNumber: 'ADM1234',
      dateOfAdmission: '10 Jun 2012',
      dateOfBirth: '12 Jan 2007',
      parentEmail: 'parent@example.com',
      motherName: 'B Sharma',
      fatherName: 'A Sharma',
      address: '123, Model Town, Kolkata',
      imagePath: '',
    );
  }

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return Student.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('API returned error: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('API error: $e');
    return Student(
      name: "Abhishek Sharma",
      classSection: '10-B',
      rollNumber: '12',
      aadhaar: '1234-5678-9012',
      academicYear: '2024-2025',
      admissionClass: 'Nursery',
      oldAdmissionNumber: 'ADM1234',
      dateOfAdmission: '10 Jun 2012',
      dateOfBirth: '12 Jan 2007',
      parentEmail: 'parent@example.com',
      motherName: 'B Sharma',
      fatherName: 'A Sharma',
      address: '123, Model Town, Kolkata',
      imagePath: '',
    );
  }
}

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  late Future<Student> _futureStudent;
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _futureStudent = fetchStudentProfile();
  }

  String safe(String? value) => value ?? 'NULL';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Student>(
      future: _futureStudent,
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
              title: const Text('Profile', style: TextStyle(fontSize: 20, color: Colors.white)),
              backgroundColor: Colors.blue[800],
              leading: const BackButton(color: Colors.white),
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
                          border: Border.all(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: Dialog(
                                        backgroundColor: Colors.transparent,
                                        insetPadding: const EdgeInsets.all(10),
                                        child: Center(
                                          child: _pickedImage != null
                                              ? Image.file(_pickedImage!, fit: BoxFit.contain)
                                              : (student.imagePath != null && student.imagePath!.startsWith('http'))
                                              ? Image.network(student.imagePath!, fit: BoxFit.contain)
                                              : Image.asset('assets/images/default.png', fit: BoxFit.contain),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: SizedBox(
                                height: 70,
                                width: 70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: _pickedImage != null
                                      ? Image.file(_pickedImage!, fit: BoxFit.cover)
                                      : (student.imagePath != null && student.imagePath!.startsWith('http'))
                                      ? Image.network(student.imagePath!, fit: BoxFit.cover)
                                      : Image.asset('assets/images/default.png', fit: BoxFit.cover),
                                ),
                              ),
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
                                    '${safe(student.classSection)} |Roll No. ${safe(student.rollNumber)}',
                                    style: const TextStyle(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                IconButton(
                                  icon: const Icon(Icons.camera_alt_outlined),
                                  onPressed: _pickImage,
                                )
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
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label1, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(child: Text(value1, style: const TextStyle(fontSize: 14))),
                    const Icon(Icons.lock_outline, size: 16, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 5),
                Container(height: 1, color: Colors.grey),
              ],
            ),
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label2, style: const TextStyle(color: Colors.grey)),
                Row(
                  children: [
                    Expanded(child: Text(value2, style: const TextStyle(fontSize: 14))),
                    const Icon(Icons.lock_outline, size: 16, color: Colors.grey),
                  ],
                ),
                Container(height: 1, color: Colors.grey),
              ],
            ),
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
          const SizedBox(height: 5),
          SizedBox(
            width: 340,
            child: Row(
              children: [
                Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
                const Icon(Icons.lock_outline, size: 16, color: Colors.grey),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(height: 1, width: 340, color: Colors.grey),
        ],
      ),
    );
  }
}
