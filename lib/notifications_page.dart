import 'package:flutter/material.dart';
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> mockNotifications=[
      "Your homework has been updated.",
      "New class timetable is available.",
      "School will be closed on Friday.",
      "Your fee payment is due tomorrow.",
    ];
    return Scaffold(
      appBar:AppBar(
        title:Text('Notifications'),
        backgroundColor:Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body:ListView.builder(
        itemCount:mockNotifications.length,
        itemBuilder:(context,index){
          return Card(
              margin:const EdgeInsets.symmetric(
                  horizontal: 12,vertical: 6
              ),
              child:ListTile(
                leading: const Icon(Icons.notifications),
                title: Text(mockNotifications[index]),
              )
          );
        },
      ),
    );
  }
}
