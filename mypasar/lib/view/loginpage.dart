import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mypasar/model/config.dart';
import 'package:mypasar/model/user.dart';
import 'package:mypasar/view/registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

import 'mainpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double screenHeight, screenWidth, resWidth;
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final TextEditingController _emailditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    loadPref();
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [upperHalf(context), lowerHalf(context)],
          ),
        ),
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return SizedBox(
      height: screenHeight / 3.5,
      width: resWidth * 0.7,
      child: Image.asset(
        'assets/images/mypasar.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
        width: resWidth,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Card(
                elevation: 10,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(25, 10, 20, 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: resWidth * 0.05,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) => val!.isEmpty ||
                                      !val.contains("@") ||
                                      !val.contains(".")
                                  ? "enter a valid email"
                                  : null,
                              focusNode: focus,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus1);
                              },
                              controller: _emailditingController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  labelStyle: TextStyle(),
                                  labelText: 'Email',
                                  icon: Icon(
                                    Icons.phone,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            validator: (val) =>
                                val!.isEmpty ? "Enter a password" : null,
                            focusNode: focus1,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus2);
                            },
                            controller: _passEditingController,
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(),
                                labelText: 'Password',
                                icon: Icon(
                                  Icons.lock,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                )),
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _isChecked,
                                      onChanged: (bool? value) {
                                        _onRememberMeChanged(value!);
                                      },
                                    ),
                                    const Text('Remember me',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Flexible(
                                  flex: 5,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(screenWidth / 3, 50)),
                                    child: const Text('Login'),
                                    onPressed: _loginUser,
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Register new account? ",
                    style: TextStyle(fontSize: 16.0)),
                GestureDetector(
                  onTap: () => {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RegisterPage()))
                  },
                  child: const Text(
                    " Click here",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Forgot password? ",
                    style: TextStyle(fontSize: 16.0)),
                GestureDetector(
                  onTap: null,
                  child: const Text(
                    " Click here",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )));
  }

  void _loginUser() {
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in the login credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      _isChecked = false;
      return;
    }
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."), title: const Text("Login user"));
    progressDialog.show();
    String _email = _emailditingController.text;
    String _pass = _passEditingController.text;
    http.post(Uri.parse(MyConfig.server + "/php/login_user.php"),
        body: {"email": _email, "password": _pass}).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        final jsonResponse = json.decode(response.body);
        
        print(response.body);
        User user = User.fromJson(jsonResponse);
        Fluttertoast.showToast(
            msg: "Login Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainPage(
                      user: user,
                    )));
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
      progressDialog.dismiss();
    });
  }

  void saveremovepref(bool value) async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in the login credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      _isChecked = false;
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    String email = _emailditingController.text;
    String password = _passEditingController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //save preference
      await prefs.setString('email', email);
      await prefs.setString('pass', password);
      Fluttertoast.showToast(
          msg: "Preference Stored",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    } else {
      //delete preference
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emailditingController.text = '';
        _passEditingController.text = '';
        _isChecked = false;
      });
      Fluttertoast.showToast(
          msg: "Preference Removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    }
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        _isChecked = newValue;
        if (_isChecked) {
          saveremovepref(true);
        } else {
          saveremovepref(false);
        }
      });

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    if (email.length > 1 && password.length > 1) {
      setState(() {
        _emailditingController.text = email;
        _passEditingController.text = password;
        _isChecked = true;
      });
    }
  }
}
