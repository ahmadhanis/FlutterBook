import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mypasar/model/config.dart';
import 'package:mypasar/model/product.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late double screenHeight, screenWidth, resWidth;

  var pathAsset = "assets/images/camera.png";

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
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
              height: screenHeight / 3,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: CachedNetworkImage(
                    width: screenWidth,
                    fit: BoxFit.cover,
                    imageUrl: Config.server +
                        "/mypasar/images/products/" +
                        widget.product.prid.toString() +
                        ".png",
                    placeholder: (context, url) =>
                        const LinearProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ))),
          Text(widget.product.prname.toString(),
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Table(
                  //defaultColumnWidth: FixedColumnWidth(120.0),
                  // border: TableBorder.all(
                  //     color: Colors.black, style: BorderStyle.solid, width: 2,),
                  columnWidths: const {
                    0: FractionColumnWidth(0.3),
                    1: FractionColumnWidth(0.7)
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  children: [
                    TableRow(children: [
                      const Text('Description',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(widget.product.prdesc.toString()),
                    ]),
                    TableRow(children: [
                      const Text('Price',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("RM " +
                          double.parse(widget.product.prprice.toString())
                              .toStringAsFixed(2)),
                    ]),
                    TableRow(children: [
                      const Text('Quantity',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(widget.product.prqty.toString()),
                    ]),
                    TableRow(children: [
                      const Text('State',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(widget.product.prstate.toString()),
                    ]),
                    TableRow(children: [
                      const Text('Locality',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(widget.product.prloc.toString()),
                    ]),
                    TableRow(children: [
                      const Text('Delivery',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("RM " +
                          double.parse(widget.product.prdel.toString())
                              .toStringAsFixed(2)),
                    ]),

                    TableRow(children: [
                      const Text('Owner',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                          widget.product.user_name.toString()),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
