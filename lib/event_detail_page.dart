import 'package:flutter/material.dart';
import 'package:student1/event_model.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[800],
          centerTitle: true,
          title: const Text("Event Enrollment",style: TextStyle(fontSize: 20,color: Colors.white),),
          leading: BackButton(color: Colors.white,),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))
          ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(event.imageUrl, height: 180, width: double.infinity, fit: BoxFit.contain),
            const SizedBox(height: 16),
            Text(event.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(event.dateTime, style: const TextStyle(color: Colors.blue)),
            const SizedBox(height: 8),
            Text(event.location, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Text(
              "${event.description}\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. "
                  "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // handle registration here
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.blue[800], // Set your desired color here
                foregroundColor: Colors.white,     // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Optional: rounded corners
                ),
              ),
              child: const Text("Register Now"),
            ),
          ],
        ),
      ),
    );
  }
}
