import 'dart:async';
import 'dart:io';
import 'package:mypasar/model/config.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mypasar/model/user.dart';

class BillPage extends StatefulWidget {
  final User user;
  final int credit;
  final String usercredit;

  const BillPage({Key? key, required this.user, required this.credit, required this.usercredit})
      : super(key: key);

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late double screenHeight, screenWidth, resWidth;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
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
      appBar: AppBar(
        title: const Text('Bill'),
      ),
      body: Center(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: WebView(
            initialUrl: MyConfig.server +
                'php/payment.php?email=' +
                widget.user.email.toString() +
                '&mobile=' +
                widget.user.phone.toString() +
                '&name=' +
                widget.user.name.toString() +
                '&curcredit=' +
                widget.usercredit.toString() +
                '&amount=' +
                widget.credit.toString(),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
          ),
        ),
      ),
    );
  }
}
