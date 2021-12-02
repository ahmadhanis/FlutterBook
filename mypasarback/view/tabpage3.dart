import 'package:flutter/material.dart';
import 'package:mypasar/model/user.dart';
import 'package:mypasar/view/loginpage.dart';
import 'registerpage.dart';

class TabPage3 extends StatefulWidget {
  final User user;
  const TabPage3({Key? key, required this.user}) : super(key: key);

  @override
  _TabPage3State createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Flexible(
            flex: 4,
            child: Card(
              elevation: 10,
              child: Row(
                children: [
                  Flexible(flex: 4, child: Container()),
                  Flexible(
                      flex: 6,
                      child: Column(
                        children: [
                          Text(widget.user.name.toString()),
                        ],
                      ))
                ],
              ),
            )),
        Flexible(
            flex: 6,
            child: Column(
              children: [
                Container(
                  color: Colors.tealAccent,
                  child: const Center(
                    child: Text("PROFILE SETTINGS",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ),
                Expanded(
                    child: ListView(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        shrinkWrap: true,
                        children: [
                      const MaterialButton(
                        onPressed: null,
                        child: Text("UPDATE NAME"),
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.tealAccent,
                      ),
                      const MaterialButton(
                        onPressed: null,
                        child: Text("UPDATE PASSWORD"),
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.tealAccent,
                      ),
                      const MaterialButton(
                        onPressed: null,
                        child: Text("UPDATE LOCATION"),
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.tealAccent,
                      ),
                      MaterialButton(
                        onPressed: _registerAccount,
                        child: const Text("NEW REGISTRATION"),
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.tealAccent,
                      ),
                      MaterialButton(
                        onPressed: _loginDialog,
                        child: const Text("LOGIN"),
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.tealAccent,
                      ),
                      const MaterialButton(
                        onPressed: null,
                        child: Text("BUY CREDIT"),
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.tealAccent,
                      ),
                    ])),
              ],
            )),
      ],
    ));
  }

  void _registerAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new Account",
            style: TextStyle(),
          ),
          content: const Text(
            "Are you sure?",
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.tealAccent,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const RegisterPage()));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.tealAccent,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _loginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new Account",
            style: TextStyle(),
          ),
          content: const Text(
            "Are you sure?",
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.tealAccent,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage()));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.tealAccent,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
