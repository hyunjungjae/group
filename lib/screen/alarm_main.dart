import 'package:flutter/material.dart';

class Alarm extends StatelessWidget {
  const Alarm({super.key});

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: const Color(0xFF994B00),
      title: const Text(
        '알림',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: Container(),
    );
  }
}
