import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mypasar/model/config.dart';
import 'package:mypasar/model/product.dart';
import 'package:mypasar/model/user.dart';
import 'package:mypasar/view/newproduct.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import 'prdetailspage.dart';

class TabPage2 extends StatefulWidget {
  final User user;
  const TabPage2({Key? key, required this.user}) : super(key: key);

  @override
  _TabPage2State createState() => _TabPage2State();
}

class _TabPage2State extends State<TabPage2> {
  List productlist = [];
  String titlecenter = "Loading data...";
  late double screenHeight, screenWidth, resWidth;
  final df = DateFormat('dd/MM/yyyy hh:mm a');
  late ScrollController _scrollController;
  int scrollcount = 5, rowcount = 2;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _loadProducts();
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
                    padding: EdgeInsets.all(8.0),
                    child: Text("Your Current Products",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
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
                onTap: _newProduct),
          ],
        ));
  }

  // int loadPages(int prlist) {
  //   int itemperpage = 10;
  //   if (prlist <= 10) {
  //     return prlist;
  //   }

  // }

  String truncateString(String str) {
    if (str.length > 15) {
      str = str.substring(0, 15);
      return str + "...";
    } else {
      return str;
    }
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (productlist.length > scrollcount) {
          scrollcount = scrollcount + 5;
          if (scrollcount > productlist.length) {
            scrollcount = productlist.length;
          }
        }
      });
    }
    // if (_scrollController.offset <=
    //         _scrollController.position.minScrollExtent &&
    //     !_scrollController.position.outOfRange) {
    //   setState(() {
    //     message = "reach the top";
    //   });
    // }
  }

  Future<void> _newProduct() async {
    if (widget.user.email == "na") {
      Fluttertoast.showToast(
          msg: "Only registered account can use this feature",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.red,
          fontSize: 14.0);
      return;
    }
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                NewProductPage(user: widget.user)));
    _loadProducts();
  }

  _loadProducts() {
    if (widget.user.email == "na") {
      setState(() {
        titlecenter = "Unregistered User";
      });
      return;
    }
    http.post(Uri.parse(Config.server + "/mypasar/php/load_products.php"),
        body: {"userid": widget.user.id}).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        print(response.body);
        var extractdata = json.decode(response.body);
        setState(() {
          productlist = extractdata["products"];
        });
      } else {
        setState(() {
          titlecenter = "No Data";
        });
      }
    });
  }

  _prodDetails(int index) async {
    Product product = Product(
        prid: productlist[index]['prid'],
        prname: productlist[index]['prname'],
        prdesc: productlist[index]['prdesc'],
        prprice: productlist[index]['prprice'],
        prqty: productlist[index]['prqty'],
        prdel: productlist[index]['prdel'],
        prstate: productlist[index]['prstate'],
        prloc: productlist[index]['prloc'],
        prlat: productlist[index]['prlat'],
        prlong: productlist[index]['prlong'],
        prdate: productlist[index]['prdate']);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PrDetailsPage(
                  product: product,
                )));
    _loadProducts();
  }
}