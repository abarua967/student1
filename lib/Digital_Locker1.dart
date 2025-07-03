import 'package:flutter/material.dart';
import 'package:student1/digital_locker.dart';

class DigitalLockerPage extends StatelessWidget {
  const DigitalLockerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Digital Locker", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 40,),
          // Top Image
          Container(
            width: double.infinity,
            height: 180,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/locker.png'), // <- replace with your banner
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'STORE & VIEW YOUR FILES',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),

          const SizedBox(height: 20),

          // Grid buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLockerTile(
                      context,
                      Icons.description,
                      'Issued\nDocuments',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DocumentsPage()),
                        );
                      },
                    ),
                    _buildLockerTile(
                      context,
                      Icons.school,
                      'Personal\nUploads',
                          () {

                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_file_rounded, size: 30, color: Colors.blue[700]),
                              const SizedBox(height: 8),
                              const Text(
                                'Upload File',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockerTile(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return Container(
      width: 160,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.blue[700]),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

}
