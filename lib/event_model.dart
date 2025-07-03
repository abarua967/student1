import 'package:flutter/material.dart';
class Event {
  final String id;
  final String title;
  final String description;
  final String dateTime;
  final String imageUrl;
  final String location;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.imageUrl,
    required this.location,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: json['dateTime'],
      imageUrl: json['imageUrl'],
      location: json['location'],
    );
  }
}
