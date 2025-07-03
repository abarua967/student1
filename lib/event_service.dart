import 'package:student1/event_model.dart';
class EventService {
  Future<List<Event>> fetchEvents() async {
    // TODO: Replace this with your API call using http.get(...)
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    return [
      Event(
        id: '1',
        title: 'Playover Puzzle',
        description:
        'A playover is a great treat for kids. Many schools use such an event...',
        dateTime: '06 Jan 23, 09:00 AM',
        imageUrl: 'assets/images/puzzle.png',
        location: 'Silver Sands Middle School, Port Orange, Florida',
      ),
      Event(
        id: '2',
        title: 'Fishing Tournament',
        description:
        'Silver Sands Middle School offers many special events, but one...',
        dateTime: '12 Jan 23, 09:00 AM',
        imageUrl: 'assets/images/fish.png',
        location: 'Silver Sands Middle School, Port Orange, Florida',
      ),
      Event(
        id: '3',
        title: 'Rhyme Time: A Night of Poetry',
        description:
        'April is National Poetry Month. A great theme for a fun night!',
        dateTime: '24 Jan 23, 09:00 AM',
        imageUrl: 'assets/images/poetry.png',
        location: 'Silver Sands Middle School, Port Orange, Florida',
      ),
    ];
  }
}
