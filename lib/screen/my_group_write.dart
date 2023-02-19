import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/screen/home_detail.dart';

class MyGroupWrite extends StatefulWidget {
  const MyGroupWrite({super.key});

  @override
  State<MyGroupWrite> createState() => _MyGroupWriteState();
}

class _MyGroupWriteState extends State<MyGroupWrite> {
  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: const Color(0xFF994B00),
      title: const Text(
        '내가 만든 모임',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  CollectionReference product =
      FirebaseFirestore.instance.collection('group_write');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController introduceController = TextEditingController();

  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    nameController.text = documentSnapshot['name'];
    categoryController.text = documentSnapshot['category'];
    areaController.text = documentSnapshot['area'];
    introduceController.text = documentSnapshot['introduce'];

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'category'),
                ),
                TextField(
                  controller: areaController,
                  decoration: const InputDecoration(labelText: 'area'),
                ),
                TextField(
                  controller: introduceController,
                  decoration: const InputDecoration(labelText: 'introduce'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = nameController.text;
                    final String category = categoryController.text;
                    final String area = areaController.text;
                    final String introduce = introduceController.text;
                    product.doc(documentSnapshot.id).update(
                      {
                        "name": name,
                        "category": category,
                        "area": area,
                        "introduce": introduce,
                      },
                    );

                    nameController.text = "";
                    categoryController.text = "";
                    areaController.text = "";
                    introduceController.text = "";
                    Navigator.of(context).pop();
                  },
                  child: const Text('update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(String produciId) async {
    await product.doc(produciId).delete();
  }

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
                          leading: SizedBox(
                              height: 70,
                              width: 70,
                              child: Image.network(documentSnapshot['image'])),
                          title: Text(documentSnapshot['name']),
                          subtitle: Text(documentSnapshot['category']),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _update(documentSnapshot);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _delete(documentSnapshot.id);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Get.to(() => DetailWritePage(
                                  documentSnapshot: documentSnapshot,
                                ));
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
