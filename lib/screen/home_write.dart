import 'dart:io';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Write extends StatefulWidget {
  const Write({Key? key}) : super(key: key);

  @override
  State<Write> createState() => _WriteState();
}

// 사진 선택 및 가져오기
class _WriteState extends State<Write> {
  File? _image;

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
    if (_image == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(_image!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (_) {}
  }

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final areaController = TextEditingController();
  final introduceController = TextEditingController();

  String imageUrl = "";
  String name = "";
  String category = "";
  String area = "";
  String introduce = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '모임 등록',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF994B00),
        elevation: 0.0,
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
        // 글 등록 완료 버튼
        actions: [
          IconButton(
              onPressed: () {
                if (imageUrl.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please upload an image'),
                    ),
                  );
                  return;
                }
                fireStore.collection('group_write').doc().set({
                  "image": imageUrl,
                  "name": name,
                  "category": category,
                  "area": area,
                  "introduce": introduce,
                });
                Get.back();
              },
              icon: const Icon(
                Icons.check,
                color: Colors.white,
                size: 25,
              ))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(40),
        children: [
          Column(
            children: <Widget>[
              Builder(
                builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: (_image != null)
                                ? Image.file(_image!)
                                : IconButton(
                                    onPressed: () {
                                      getImage();
                                    },
                                    icon: const Icon(Icons.camera_alt),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              // 모임 이름 텍스트
              TextField(
                cursorColor: Colors.black,
                maxLength: 30,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),

                  fillColor: Colors.white, filled: true,
                  counterText: '', // '0/30' 숨김
                  contentPadding: const EdgeInsets.all(10),
                  hintText: ' 모임 이름',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black38)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black38)),
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),

              const SizedBox(height: 15),
              // 카테고리 버튼
              TextField(
                cursorColor: Colors.black,
                maxLength: 30,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),

                  fillColor: Colors.white, filled: true,
                  counterText: '', // '0/30' 숨김
                  contentPadding: const EdgeInsets.all(10),
                  hintText: ' 카테고리',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black38)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black38)),
                ),
                onChanged: (value) {
                  setState(() {
                    category = value;
                  });
                },
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     FocusScope.of(context).unfocus();
              //     Navigator.push(
              //       context,
              //       CupertinoPageRoute(
              //           builder: (context) => const Category(),
              //           fullscreenDialog: false),
              //     );
              //   },
              //   style: OutlinedButton.styleFrom(
              //       foregroundColor: Colors.black54,
              //       backgroundColor: const Color(0x00ffffff),
              //       elevation: 0.0,
              //       fixedSize: const Size(350, 50),
              //       side: const BorderSide(color: Colors.black38)),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: const [
              //       Text('카테고리', style: TextStyle(fontSize: 15)),
              //       Icon(Icons.chevron_right, color: Colors.black38)
              //     ],
              //   ),
              // ),

              const SizedBox(height: 15),

              // 지역 버튼
              TextField(
                cursorColor: Colors.black,
                maxLength: 30,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),

                  fillColor: Colors.white, filled: true,
                  counterText: '', // '0/30' 숨김
                  contentPadding: const EdgeInsets.all(10),
                  hintText: ' 지역',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black38)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black38)),
                ),
                onChanged: (value) {
                  setState(() {
                    area = value;
                  });
                },
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     FocusScope.of(context).unfocus();
              //     Navigator.push(
              //       context,
              //       CupertinoPageRoute(
              //           builder: (context) => const Area(),
              //           fullscreenDialog: false),
              //     );
              //   },
              //   style: OutlinedButton.styleFrom(
              //       foregroundColor: Colors.black54,
              //       backgroundColor: Colors.white,
              //       elevation: 0.0,
              //       fixedSize: const Size(350, 50),
              //       side: const BorderSide(color: Colors.black38)),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: const [
              //       Text('지역', style: TextStyle(fontSize: 15)),
              //       Icon(Icons.chevron_right, color: Colors.black38)
              //     ],
              //   ),
              // ),

              const SizedBox(height: 15),

              // 모임 소개
              TextField(
                maxLines: 5,
                maxLength: 300, // 최대 글자 수
                decoration: InputDecoration(
                  fillColor: Colors.white, filled: true,
                  counterText: '', // '0/300' 숨김
                  contentPadding: const EdgeInsets.all(10),
                  hintText: ' 모임을 소개해주세요.',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black38)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black38)),
                ),
                onChanged: (value) {
                  setState(() {
                    introduce = value;
                  });
                },
                cursorColor: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
