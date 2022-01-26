import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mypasar/model/config.dart';
import 'package:mypasar/model/user.dart';
import 'billpage.dart';
import 'package:http/http.dart' as http;

class CreditPage extends StatefulWidget {
  final User user;
  const CreditPage({Key? key, required this.user}) : super(key: key);

  @override
  State<CreditPage> createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> {
  late double screenHeight, screenWidth, resWidth;
  final df = DateFormat('dd/MM/yyyy hh:mm a');
  final bool _value = false;
  int val = -1;
  List<String> creditType = ["5", "10", "15", "20", "25", "50", "100", "1000"];
  String selectedValue = "5";
  double price = 0.0;

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
        title: const Text('Buy More Credit'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
              child: Card(
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: screenHeight * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Card(
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: screenWidth,
                    height: screenHeight * 0.35,
                    child: Column(
                      children: [
                        const Text("BUY CREDIT",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        const Text("Select Credit Value "),
                        SizedBox(
                          height: 60,
                          width: 100,
                          child: DropdownButton(
                            isExpanded: true,
                            //sorting dropdownoption
                            hint: const Text(
                              'Please select credit value',
                              style: TextStyle(
                                color: Color.fromRGBO(101, 255, 218, 50),
                              ),
                            ), // Not necessary for Option 1
                            value: selectedValue,
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue.toString();

                                print(selectedValue);
                              });
                            },
                            items: creditType.map((selectedValue) {
                              return DropdownMenuItem(
                                child: Text(selectedValue, style: TextStyle()),
                                value: selectedValue,
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                            "RM " +
                                double.parse(selectedValue).toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          child: Text("BUY"),
                          onPressed: _buycreditDialog,
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(screenWidth / 2, 50)),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void _buycreditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text(
            "Buy Credit RM " +
                double.parse(selectedValue).toStringAsFixed(2) +
                "?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => BillPage(
                              user: widget.user,
                              credit: int.parse(selectedValue),
                              usercredit: widget.user.credit.toString(),
                            )));
                _loadNewCredit();
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

  _loadNewCredit() {
    http.post(Uri.parse(MyConfig.server + "/php/load_user.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        final jsonResponse = json.decode(response.body);
        print(response.body);
        User user = User.fromJson(jsonResponse);
        setState(() {
          widget.user.credit = user.credit;
        });
      }
    });
  }
}
