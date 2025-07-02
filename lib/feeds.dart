import 'package:flutter/material.dart';
import 'package:student1/notice.dart';

class NoticeBoard extends StatefulWidget {
  const NoticeBoard({super.key});

  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  final List<Map<String, String>> notices = List.generate(10, (index) {
    return {
      "title": "Notice $index",
      "date": "dd/mm/20yy",
      "image": "assets/images/vacation.png"
    };
  },
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 30) / 2; // Adjust spacing

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice Board', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(notices.length, (index) {
            final notice = notices[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Notice()),
                );
              },
              child: SizedBox(
                width: cardWidth,
                height: 180,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        notice["image"]!,
                        height: 50,
                        width: 50,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      Text(notice["title"] ?? ''),
                      Text(notice["date"] ?? ''),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
