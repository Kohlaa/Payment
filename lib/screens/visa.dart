// import 'package:flutter/material.dart';
// import 'package:payment/shared/components/constants.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class VisaScreen extends StatefulWidget {
//   static const String routeName = "visaScreen";
//
//   @override
//   State<VisaScreen> createState() => _VisaScreenState();
// }
//
// class _VisaScreenState extends State<VisaScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebView(
//         initialUrl:
//             "https://accept.paymobsolutions.com/api/acceptance/iframes/753361?payment_token=$REQUEST_TOKEN_CARD",
//       ),
//     );
//   }
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payment/shared/components/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisaScreen extends StatefulWidget {
  static const String routeName = "visaScreen";

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl:
        "https://accept.paymobsolutions.com/api/acceptance/iframes/753361?payment_token=$REQUEST_TOKEN_CARD",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        backgroundColor: const Color(0x00000000),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}