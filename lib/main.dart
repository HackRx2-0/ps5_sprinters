import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import './widgets/app_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late WebViewController _myController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bajaj Finserv',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('BAJAJ Finserv'),
          backgroundColor: Colors.blue[800],
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.menu,
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              }),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          actions: [
            Icon(Icons.notifications),
            Icon(Icons.more_vert),
          ],
        ),
        drawer: AppDrawer(),
        body: WebView(
          initialUrl: "https://www.bajajfinserv.in/",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
            _myController = webViewController;
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            _myController.evaluateJavascript(
                "document.getElementsByClassName(\"navbar\")[0].style.display='none';");
          },
        ),
      ),
    );
  }
}
