import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/screen/alarm_main.dart';
import 'package:group/screen/area.dart';
import 'package:group/screen/home_detail.dart';
import 'package:group/screen/home_search.dart';
import 'package:group/screen/home_write.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot>? streamData;

  @override
  void initState() {
    super.initState();
    streamData = firestore.collection("group_write").snapshots();
  }

  CollectionReference product =
      FirebaseFirestore.instance.collection('group_write');

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          Get.to(() => const Area(), transition: Transition.fade);
        },
        child: Row(
          children: const [
            Text("대야동"),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF994B00),
      elevation: 3.0,

      // 글 등록 페이지로 이동
      actions: [
        IconButton(
          color: Colors.white,
          iconSize: 23,
          onPressed: () {
            Get.to(() => const Write(), transition: Transition.fade);
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          color: Colors.white,
          iconSize: 23,
          onPressed: () {
            Get.to(() => const HomeSearch(), transition: Transition.fade);
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          color: Colors.white,
          iconSize: 23,
          onPressed: () {
            Get.to(() => const Alarm(), transition: Transition.fade);
          },
          icon: const Icon(Icons.notifications),
        ),
      ],
    );
  }

  Widget bodyWidget() {
    return StreamBuilder(
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
        if (streamsnapshot.hasData) {
          return ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 8 / 10,
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0),
              physics: const ClampingScrollPhysics(),
              itemCount: streamsnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamsnapshot.data!.docs[index];

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () async {
                      Get.to(
                          () => DetailWritePage(
                              documentSnapshot: documentSnapshot),
                          transition: Transition.fade);
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.network(
                            documentSnapshot['image'],
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                documentSnapshot['name'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(documentSnapshot['area']),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text("날짜 및 시간"),
                            ),
                          ],
                        ),
                      ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: bodyWidget(),
    );
  }
}
