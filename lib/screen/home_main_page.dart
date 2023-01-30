import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/screen/home_category.dart';
import 'package:group/screen/home_detail_page.dart';
import 'package:group/screen/home_write.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: const Text(
        'GROUP',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xFF994B00),
      centerTitle: true,
      elevation: 0.0,

      // 카테고리 선택
      leading: IconButton(
        onPressed: () {
          Get.to(() => const HomeCategory(),
              transition: Transition.leftToRight);
        },
        icon: const Icon(Icons.menu),
      ),

      // 글 등록 페이지로 이동
      actions: [
        IconButton(
          color: Colors.white,
          iconSize: 20,
          onPressed: () {
            Get.to(() => const Write(), transition: Transition.downToUp);
          },
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }

  CollectionReference product =
      FirebaseFirestore.instance.collection('group_write');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: Padding(
        padding: const EdgeInsets.only(top: 7, bottom: 7),
        child: StreamBuilder(
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamsnapshot) {
            if (streamsnapshot.hasData) {
              return ScrollConfiguration(
                behavior: const ScrollBehavior()
                    .copyWith(overscroll: false), // 스크롤 물결 X
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: streamsnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamsnapshot.data!.docs[index];
                    return SizedBox(
                      height: 100,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.only(
                            left: 14, right: 14, bottom: 7, top: 7),
                        child: ListTile(
                          leading: const Icon(
                            //
                            (Icons.dangerous),
                            size: 60,
                          ),
                          title: Text(documentSnapshot['name']),
                          subtitle: Text(documentSnapshot['category']),
                          // isThreeLine: true,
                          onTap: () {
                            Get.to(() => const DetailWritePage());
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
          stream: product.snapshots(),
        ),
      ),
    );
  }
}
