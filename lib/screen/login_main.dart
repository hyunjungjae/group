import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:group/screen/login_google.dart';
import 'package:group/widget/bottom_navi.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const LoginGoogle();
        } else {
          return const BottomNavi();
        }
      }),
    );
  }
}
