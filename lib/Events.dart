import 'package:flutter/material.dart';
import 'package:student1/event_model.dart';
import 'package:student1/event_service.dart';
import 'package:student1/event_detail_page.dart';

class EventsPage extends StatelessWidget {
  final EventService _eventService = EventService();

  EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        centerTitle: true,
          title: const Text("Events & Programs",style: TextStyle(fontSize: 20,color: Colors.white),),
        leading: BackButton(color: Colors.white,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))
        ),

      ),
      body: FutureBuilder<List<Event>>(
        future: _eventService.fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Text(
                    "All Upcoming Events",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              ...events.map((event) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Image.asset(event.imageUrl,
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(event.title),
                  subtitle:
                  Text("${event.dateTime}\n${event.description}"),
                  isThreeLine: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EventDetailPage(event: event),
                    ),
                  ),
                ),
              )),
            ],
          );
        },
      ),

    );
  }
}
