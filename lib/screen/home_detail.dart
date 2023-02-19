import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailWritePage extends StatefulWidget {
  const DetailWritePage({super.key, required this.documentSnapshot});

  final DocumentSnapshot documentSnapshot;

  @override
  State<DetailWritePage> createState() => _DetailWritePageState();
}

class _DetailWritePageState extends State<DetailWritePage> {
  bool isLiked = false;
  int likedCount = 0;

  void _toggleFavorite() {
    setState(() {
      if (isLiked) {
        likedCount -= 1;
        isLiked = false;
      } else {
        likedCount += 1;
        isLiked = true;
      }
    });
  }

  CollectionReference product =
      FirebaseFirestore.instance.collection("group_favorite");

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: const Color(0xFF994B00),
      title: Text(
        widget.documentSnapshot.get("name"),
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 320,
                          height: 250,
                          child: Image.network(
                            widget.documentSnapshot['image'],
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(widget.documentSnapshot["area"]),
                      Text(widget.documentSnapshot["category"]),
                      Text(widget.documentSnapshot["introduce"]),
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: product.where("name").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                if (streamsnapshot.data == null) {
                  return const Text("Wow");
                }
                return SizedBox(
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _toggleFavorite,
                        icon: isLiked
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                                size: 30,
                              ),
                      ),
                      SizedBox(
                        width: 18,
                        child: SizedBox(
                          child: Text("$likedCount"),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 280,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: const Color(0xFF994B00)),
                          child: const Text(
                            "신청하기",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
