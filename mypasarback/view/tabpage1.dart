import 'package:flutter/material.dart';

class TabPage1 extends StatefulWidget {
  const TabPage1({ Key? key }) : super(key: key);

  @override
  _TabPage1State createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child:Text("TAB 1")
    );
  }
}