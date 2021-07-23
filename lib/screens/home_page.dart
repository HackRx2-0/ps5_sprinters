import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController _myController;
  final _key = UniqueKey();
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Stack(
                children: [
                  WebView(
                    key: _key,
                    initialUrl: "https://www.bajajfinserv.in/",
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                      _myController = webViewController;
                    },
                    onPageFinished: (String url) {
                      print('Loaded');
                      setState(() {
                        isLoading = false;
                      });
                      print('Page finished loading: $url');
                      _myController.evaluateJavascript(
                          "document.getElementsByClassName(\"navbar\")[0].style.display='none';");
                    },
                  ),
                  isLoading
                      ? Center(
                          child: SpinKitPulse(
                            color: Colors.blue[900],
                            size: 70,
                          ),
                        )
                      : Stack(),
                ],
              )
    );
  }
}