import 'package:flutter/material.dart';
import 'package:group/screen/chat_main.dart';
import 'package:group/screen/gallery_main.dart';
import 'package:group/screen/home_main_page.dart';
import 'package:group/screen/my_main.dart';
import 'package:group/screen/search_main.dart';

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
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Image.asset(
              'assets/images/home_icon.png',
              color: Colors.white,
              width: 20,
              height: 20,
              filterQuality: FilterQuality.high,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/search_icon.png',
                color: Colors.white,
                width: 25,
                height: 25,
                filterQuality: FilterQuality.high,
              ),
              label: '검색'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/gallery_icon.png',
                color: Colors.white,
                width: 20,
                height: 20,
                filterQuality: FilterQuality.high,
              ),
              label: '게시판'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/chat_icon.png',
                color: Colors.white,
                width: 20,
                height: 20,
                filterQuality: FilterQuality.high,
              ),
              label: '채팅'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/myPage_icon.png',
                color: Colors.white,
                width: 20,
                height: 20,
                filterQuality: FilterQuality.high,
              ),
              label: '내 정보'),
        ],
      ),
    );
  }
}
