import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group/model/my_group_write.dart';

class My extends StatelessWidget {
  const My({Key? key}) : super(key: key);

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: const Color(0xFF994B00),
      title: const Text(
        '내 정보',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 7, top: 7),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: 300,
                height: 80,
                child: Row(
                  children: [
                    const Icon(
                      Icons.face,
                      size: 50,
                    ),
                    const Spacer(flex: 5),
                    const Text('user name'),
                    const Spacer(flex: 20),
                    const Icon(Icons.settings),
                    const Spacer(flex: 5),
                    IconButton(
                      // onPressed: GoogleSignIn().signOut,
                      onPressed: FirebaseAuth.instance.signOut,
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: const Text('내가 만든 모임'),
                      subtitle: const Text('아직 미정'),
                      onTap: () {
                        Get.to(() => const MyGroupWrite());
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: const Text('내가 가입한 모임'),
                      subtitle: const Text('아직 미정'),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const (),
                        //   ),
                        // );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
