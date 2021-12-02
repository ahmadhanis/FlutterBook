import 'package:flutter/material.dart';
import 'package:mypasar/model/user.dart';

class TabPage1 extends StatefulWidget {
  final User user;
  const TabPage1({Key? key, required this.user}) : super(key: key);

  @override
  State<TabPage1> createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(widget.user.email.toString()),
      ),
    );
  }
}
