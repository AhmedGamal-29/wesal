import 'package:flutter/material.dart';
import 'package:marry_me/services/globals.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:webview_flutter/webview_flutter.dart';

import '../services/auth_services.dart';


class WebViewExample extends StatefulWidget {
  static const id = "webview_screen";
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
 late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
     WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        onWebViewCreated: (controller){
          _webViewController=controller;



        },
        initialUrl: home_url+'chatify',
        onPageStarted: (url){
          Map<String, String> header = {"Content-Type": "application/json",
            "Authorization":AuthServices.token,
          };
         // _webViewController.loadUrl(url,headers: header);
          _webViewController.loadRequest(WebViewRequest(uri: Uri.parse(home_url+'chatify'),
              method:WebViewRequestMethod.get,
          headers: header)

          );
          _webViewController.reload();
        },

      ),
    );
  }
}