import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mypasar/model/config.dart';
import 'package:mypasar/model/user.dart';
import 'package:mypasar/view/loginpage.dart';
import 'creditpage.dart';
import 'registerpage.dart';
import 'package:http/http.dart' as http;

class TabPage3 extends StatefulWidget {
  final User user;
  const TabPage3({Key? key, required this.user}) : super(key: key);

  @override
  _TabPage3State createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> {
  late double screenHeight, screenWidth, resWidth;
  File? _image;
  var pathAsset = "assets/images/profile.png";
  final df = DateFormat('dd/MM/yyyy hh:mm a');

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flexible(
              flex: 4,
              child: Row(
                children: [
                  _image == null
                      ? Flexible(
                          flex: 4,
                          child: SizedBox(
                              // height: screenWidth / 2.5,
                              child: GestureDetector(
                            onTap: _selectImage,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: CachedNetworkImage(
                                imageUrl: MyConfig.server +
                                    "/images/profiles/" +
                                    widget.user.id.toString() +
                                    ".png",
                                placeholder: (context, url) =>
                                    const LinearProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.image_not_supported,
                                  size: 128,
                                ),
                              ),
                            ),
                          )),
                        )
                      : Flexible(
                          flex: 4,
                          child: SizedBox(
                              // height: screenWidth / 2.5,
                              child: GestureDetector(
                            onTap: _selectImage,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Container(
                                  decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: _image == null
                                      ? AssetImage(pathAsset)
                                      : FileImage(_image!) as ImageProvider,
                                  fit: BoxFit.fill,
                                ),
                              )),
                            ),
                          )),
                        ),
                  Flexible(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(widget.user.name.toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 8),
                            child: Divider(
                              color: Colors.blueGrey,
                              height: 2,
                              thickness: 2.0,
                            ),
                          ),
                          Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.3),
                              1: FractionColumnWidth(0.7)
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(children: [
                                const Icon(Icons.email),
                                Text(widget.user.email.toString()),
                              ]),
                              TableRow(children: [
                                const Icon(Icons.phone),
                                Text(widget.user.phone.toString()),
                              ]),
                              TableRow(children: [
                                const Icon(Icons.credit_score),
                                Text(widget.user.credit.toString()),
                              ]),
                              widget.user.regdate.toString() == ""
                                  ? TableRow(children: [
                                      const Icon(Icons.date_range),
                                      Text(df.format(DateTime.parse(
                                          widget.user.regdate.toString())))
                                    ])
                                  : TableRow(children: [
                                      const Icon(Icons.date_range),
                                      Text(widget.user.regdate.toString())
                                    ]),
                            ],
                          ),
                        ],
                      ))
                ],
              )),
        ),
        Flexible(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: Column(
                children: [
                  Container(
                    width: screenWidth,
                    alignment: Alignment.center,
                    color: Theme.of(context).backgroundColor,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                      child: Text("PROFILE SETTINGS",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  Expanded(
                      child: ListView(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          shrinkWrap: true,
                          children: [
                        MaterialButton(
                          onPressed: () => {_updateProfileDialog(1)},
                          child: const Text("UPDATE NAME"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: () => {_updateProfileDialog(2)},
                          child: const Text("UPDATE PHONE"),
                        ),
                        MaterialButton(
                          onPressed: () => {_updateProfileDialog(3)},
                          child: Text("UPDATE PASSWORD"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: _registerAccountDialog,
                          child: const Text("NEW REGISTRATION"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: _loginDialog,
                          child: const Text("LOGIN"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: buyCreditPage,
                          child: const Text("BUY CREDIT"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                      ])),
                ],
              ),
            )),
      ],
    );
  }

  void _registerAccountDialog() {
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
                style: TextStyle(),
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
                style: TextStyle(),
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
            "Go to Login Page",
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
                style: TextStyle(),
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
                style: TextStyle(),
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

  void _selectImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
              style: TextStyle(),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(resWidth * 0.2, resWidth * 0.2)),
                  child: const Text('Gallery'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    _selectfromGallery(),
                  },
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(resWidth * 0.2, resWidth * 0.2)),
                  child: const Text('Camera'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    _selectFromCamera(),
                  },
                ),
              ],
            ));
      },
    );
  }

  Future<void> _selectfromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  Future<void> _selectFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: Colors.deepOrange,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Crop Image',
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      String base64Image = base64Encode(_image!.readAsBytesSync());
      http.post(Uri.parse(MyConfig.server + "/php/update_profile.php"), body: {
        "image": base64Image,
        "userid": widget.user.id
      }).then((response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.green,
              fontSize: 14.0);
          DefaultCacheManager manager = DefaultCacheManager();
          manager.emptyCache();
          _image = null;
          setState(() {});
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.red,
              fontSize: 14.0);
        }
      });
    }
  }

  _updateProfileDialog(int i) {
    switch (i) {
      case 1:
        _updateNameDialog();
        break;
      case 2:
        _updatePhoneDialog();
        break;
      case 3:
        _updatePasswordDialog();
        break;
    }
  }

  void _updateNameDialog() {
    TextEditingController _nameeditingController = TextEditingController();
    _nameeditingController.text = widget.user.name.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Name",
            style: TextStyle(),
          ),
          content: TextField(
              controller: _nameeditingController,
              keyboardType: TextInputType.phone),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Confirm",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                http.post(
                    Uri.parse(MyConfig.server + "/php/update_profile.php"),
                    body: {
                      "name": _nameeditingController.text,
                      "userid": widget.user.id
                    }).then((response) {
                  var data = jsonDecode(response.body);
                  print(data);
                  if (response.statusCode == 200 &&
                      data['status'] == 'success') {
                    Fluttertoast.showToast(
                        msg: "Success",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.green,
                        fontSize: 14.0);
                    setState(() {
                      widget.user.name = _nameeditingController.text;
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Failed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.red,
                        fontSize: 14.0);
                  }
                });
              },
            ),
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(),
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

  void _updatePhoneDialog() {
    TextEditingController _phoneeditingController = TextEditingController();
    _phoneeditingController.text = widget.user.phone.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Phone Number",
            style: TextStyle(),
          ),
          content: TextField(
              controller: _phoneeditingController,
              keyboardType: TextInputType.phone),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Confirm",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                http.post(
                    Uri.parse(MyConfig.server + "/php/update_profile.php"),
                    body: {
                      "phone": _phoneeditingController.text,
                      "userid": widget.user.id
                    }).then((response) {
                  var data = jsonDecode(response.body);
                  print(data);
                  if (response.statusCode == 200 &&
                      data['status'] == 'success') {
                    Fluttertoast.showToast(
                        msg: "Success",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.green,
                        fontSize: 14.0);
                    setState(() {
                      widget.user.phone = _phoneeditingController.text;
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Failed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.red,
                        fontSize: 14.0);
                  }
                });
              },
            ),
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(),
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

  void _updatePasswordDialog() {
    TextEditingController _pass1editingController = TextEditingController();
    TextEditingController _pass2editingController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Update Password",
            style: TextStyle(),
          ),
          content: Container(
            height: screenHeight / 5,
            child: Column(
              children: [
                TextField(
                    controller: _pass1editingController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'New password',
                        labelStyle: TextStyle(),
                        icon: Icon(
                          Icons.password,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ))),
                TextField(
                    controller: _pass2editingController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Renter password',
                        labelStyle: TextStyle(),
                        icon: Icon(
                          Icons.password,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ))),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Confirm",
                style: TextStyle(),
              ),
              onPressed: () {
                if (_pass1editingController.text !=
                    _pass2editingController.text) {
                  Fluttertoast.showToast(
                      msg: "Passwords are not the same",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.red,
                      fontSize: 14.0);
                  return;
                }
                if (_pass1editingController.text.isEmpty ||
                    _pass2editingController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Fill in passwords",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.red,
                      fontSize: 14.0);
                  return;
                }
                Navigator.of(context).pop();
                http.post(
                    Uri.parse(MyConfig.server + "/php/update_profile.php"),
                    body: {
                      "password": _pass1editingController.text,
                      "userid": widget.user.id
                    }).then((response) {
                  var data = jsonDecode(response.body);
                  print(data);
                  if (response.statusCode == 200 &&
                      data['status'] == 'success') {
                    Fluttertoast.showToast(
                        msg: "Success",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.green,
                        fontSize: 14.0);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Failed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.red,
                        fontSize: 14.0);
                  }
                });
              },
            ),
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(),
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

  Future<void> buyCreditPage() async {
   await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CreditPage(
                  user: widget.user,
                )));
  }
}
