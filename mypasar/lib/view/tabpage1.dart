import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:mypasar/model/config.dart';
import 'package:mypasar/model/user.dart';
import 'package:http/http.dart' as http;

class TabPage1 extends StatefulWidget {
  final User user;
  const TabPage1({Key? key, required this.user}) : super(key: key);

  @override
  State<TabPage1> createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> {
  List productlist = [];
  String titlecenter = "Loading data...";
  late double screenHeight, screenWidth, resWidth;
  final df = DateFormat('dd/MM/yyyy hh:mm a');
  late ScrollController _scrollController;
  int scrollcount = 10;
  int rowcount = 2;
  int numprd = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _loadBuyerProducts();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }

    return Scaffold(
        body: productlist.isEmpty
            ? Center(
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)))
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text("Products Available",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Text(numprd.toString() + " found"),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: rowcount,
                      controller: _scrollController,
                      children: List.generate(scrollcount, (index) {
                        return Card(
                            child: InkWell(
                          onTap: () => {_prodDetails(index)},
                          child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  width: screenWidth,
                                  fit: BoxFit.cover,
                                  imageUrl: Config.server +
                                      "/mypasar/images/products/" +
                                      productlist[index]['prid'] +
                                      ".png",
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            truncateString(productlist[index]
                                                    ['prname']
                                                .toString()),
                                            style: TextStyle(
                                                fontSize: resWidth * 0.045,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "RM " +
                                                double.parse(productlist[index]
                                                        ['prprice'])
                                                    .toStringAsFixed(2) +
                                                "  -  " +
                                                productlist[index]['prqty'] +
                                                " in stock",
                                            style: TextStyle(
                                              fontSize: resWidth * 0.03,
                                            )),
                                        Text(
                                            df.format(DateTime.parse(
                                                productlist[index]['prdate'])),
                                            style: TextStyle(
                                              fontSize: resWidth * 0.03,
                                            ))
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ));
                      }),
                    ),
                  ),
                ],
              ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.add),
                label: "New Product",
                labelStyle: const TextStyle(color: Colors.black),
                labelBackgroundColor: Colors.white,
                onTap: null),
          ],
        ));
  }

  void _loadBuyerProducts() {
    http.post(Uri.parse(Config.server + "/mypasar/php/loadbuyer_products.php"),
        body: {}).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        print(response.body);
        var extractdata = json.decode(response.body);
        setState(() {
          productlist = extractdata["products"];
          numprd = productlist.length;
          if (scrollcount >= productlist.length) {
            scrollcount = productlist.length;
          }
        });
      } else {
        setState(() {
          titlecenter = "No Data";
        });
      }
    });
  }

  String truncateString(String str) {
    if (str.length > 15) {
      str = str.substring(0, 15);
      return str + "...";
    } else {
      return str;
    }
  }

  _prodDetails(int index) {}

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (productlist.length > scrollcount) {
          scrollcount = scrollcount + 10;
          if (scrollcount >= productlist.length) {
            scrollcount = productlist.length;
          }
        }
      });
    }
  }
}
