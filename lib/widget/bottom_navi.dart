import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group/screen/chat_main.dart';
import 'package:group/screen/gallery_main.dart';
import 'package:group/screen/home_main.dart';
import 'package:group/screen/my_main.dart';
import 'package:group/screen/favorite_main.dart';

class BottomNavi extends StatefulWidget {
  const BottomNavi({Key? key}) : super(key: key);

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  int _selectedIndex = 0;

  final List<Widget> _widgetList = <Widget>[
    const HomePage(),
    const Search(),
    const Gallery(),
    const Chat(),
    const My(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetList.elementAt(_selectedIndex),
      bottomNavigationBar: SizedBox(
        height: 55,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF994B00),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          // selectedFontSize: 13,
          // unselectedFontSize: 13,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/ic_home.svg",
                  color: Colors.white,
                  width: 20,
                  height: 20,
                ),
                label: "홈"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/ic_favorite.svg",
                  color: Colors.white,
                  width: 20,
                  height: 20,
                ),
                label: '좋아요'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/ic_gallery.svg",
                  color: Colors.white,
                  width: 20,
                  height: 20,
                ),
                label: '게시판'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/ic_chat.svg",
                  color: Colors.white,
                  width: 20,
                  height: 20,
                ),
                label: '채팅'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/ic_myPage.svg",
                  color: Colors.white,
                  width: 20,
                  height: 20,
                ),
                label: '내 정보'),
          ],
        ),
      ),
    );
  }
}
