import 'package:flutter/material.dart';
import 'package:group/chat/chat_main.dart';
import 'package:group/gallery/gallery_main.dart';
import 'package:group/home/home_main_page.dart';
import 'package:group/my/my_main.dart';
import 'package:group/search/search_main.dart';

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
              'asset/image/home_icon.png',
              color: Colors.white,
              width: 20,
              height: 20,
              filterQuality: FilterQuality.high,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'asset/image/search_icon.png',
                color: Colors.white,
                width: 25,
                height: 25,
                filterQuality: FilterQuality.high,
              ),
              label: '검색'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'asset/image/gallery_icon.png',
                color: Colors.white,
                width: 20,
                height: 20,
                filterQuality: FilterQuality.high,
              ),
              label: '게시판'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'asset/image/chat_icon.png',
                color: Colors.white,
                width: 20,
                height: 20,
                filterQuality: FilterQuality.high,
              ),
              label: '채팅'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'asset/image/myPage_icon.png',
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