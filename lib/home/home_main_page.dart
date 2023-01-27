import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group/home/home_category.dart';
import 'package:group/home/home_detail_page.dart';
import 'package:group/home/home_write.dart';

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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeCategory()),
          );
        },
        icon: const Icon(Icons.menu),
      ),

      // 글 등록 페이지로 이동
      actions: [
        IconButton(
          color: Colors.white,
          iconSize: 20,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const Write(), fullscreenDialog: true),
            );
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
                            Icons.logo_dev,
                            size: 60,
                          ),
                          title: Text(documentSnapshot['name']),
                          subtitle: Text(documentSnapshot['category']),
                          // isThreeLine: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailWritePage(),
                              ),
                            );
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
