
import 'dart:io';

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
        javascriptMode: JavascriptMode.unrestricted,
        zoomEnabled: true,
        onWebViewCreated: (controller){
          controller.loadUrl( home_url+'chatify',headers:  {'Authorization':'Bearer ${AuthServices.token}'});
          _webViewController=controller;
          _webViewController.reload();


        },



      ),
    );
  }
}