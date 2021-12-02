import 'package:flutter/material.dart';
import 'package:mypasar/model/user.dart';
import 'tabpage1.dart';
import 'tabpage2.dart';
import 'tabpage3.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Buyer";
  late double screenHeight, screenWidth, resWidth;

  @override
  void initState() {
    super.initState();
    tabchildren = [
      TabPage1(
        user: widget.user,
      ),
      TabPage2(user: widget.user),
      TabPage3(
        user: widget.user,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPasar'),
      ),
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.attach_money,
                size: resWidth * 0.07,
              ),
              label: "Buyer"),
          BottomNavigationBarItem(
              icon: Icon(Icons.store_mall_directory, size: resWidth * 0.07),
              label: "Seller"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: resWidth * 0.07), label: "Profile")
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        maintitle = "Buyer";
      }
      if (_currentIndex == 1) {
        maintitle = "Seller";
      }
      if (_currentIndex == 2) {
        maintitle = "Profile";
      }
    });
  }
}
