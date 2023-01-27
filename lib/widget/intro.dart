import 'dart:async';
import 'package:flutter/material.dart';
import 'package:group/model/login_main.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginMain(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('asset/image/group.png')),
    );
  }
}
