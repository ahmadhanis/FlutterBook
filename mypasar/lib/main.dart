import 'package:flutter/material.dart';
import 'package:mypasar/view/splashpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData.dark(),
        title: 'MyPasar',
        home: const Scaffold(
          body: SplashPage(),
        ));
  }
}
