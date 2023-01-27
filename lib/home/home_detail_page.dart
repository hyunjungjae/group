import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailWritePage extends StatefulWidget {
  const DetailWritePage({super.key});

  @override
  State<DetailWritePage> createState() => _DetailWritePageState();
}

class _DetailWritePageState extends State<DetailWritePage> {
//

  CollectionReference product =
      FirebaseFirestore.instance.collection('group_write');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF994B00),
        title: const Text(
          "detailPage",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
