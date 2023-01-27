import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF994B00),
        title: const Text(
          '채팅',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
    );
  }
}
