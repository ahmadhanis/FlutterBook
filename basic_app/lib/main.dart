import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  String _value = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "Enter your text below",
          ),
          TextField(
            controller: textEditingController,
          ),
          ElevatedButton(onPressed: _pressMe, child: const Text("Press Me")),
          Text(_value)
        ],
      ),
    );
  }

  void _pressMe() {
    // ignore: avoid_print
    print('Hello World');
    setState(() {
      _value = textEditingController.text;
    });
  }
}
