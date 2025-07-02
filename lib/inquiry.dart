import 'package:flutter/material.dart';

class Inquiry extends StatefulWidget {
  const Inquiry({super.key});

  @override
  State<Inquiry> createState() => _InquiryState();
}

class _InquiryState extends State<Inquiry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inquiry',style: TextStyle(color: Colors.white),),
        centerTitle:true,
        backgroundColor: Colors.blue,
      ),
      body:Expanded(child: Column(
        children: [

        ],
      ),
      ),
    );
  }
}
