import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import '../screens/sso/signup-page.dart';
import '../screens/sso/signin-reply.dart';
import '../screens/campaigns/screen.dart';
import '../global.dart' as config show UserData, authenticator;

class LogInWebView extends StatefulWidget {
  String url;
  LogInWebView(this.url);

  @override
  _LogInWebViewState createState() => _LogInWebViewState(this.url);
}

class _LogInWebViewState extends State<LogInWebView> {
  var _url;

  bool _dstReached = false;
  _LogInWebViewState(this._url);
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Login'),
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: _url,
            userAgent: "random",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              _controller = (controller);
            },
            // navigationDelegate: (NavigationRequest request) {
            //   if (request.url.startsWith(
            //       'http://192.168.34.11.nip.io:3000/auth/google/callback/')) {
            //     setState(() {
            //       _dstReached = true;
            //     });
            //     // do not navigate
            //     return NavigationDecision.prevent;
            //   }

            //   return NavigationDecision.navigate;
            // },
            onPageFinished: (finish) async {
              final resp = await _controller.runJavascriptReturningResult(
                  "document.documentElement.innerText");
              Map<String, dynamic> respMap = json.decode(json.decode(resp));
              UserCollection response = UserCollection.fromJson(respMap);
              SignUpNaviagtion(response);
            },
          );
        }));
  }

  void SignUpNaviagtion(response) {
    if (response.user != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CampaignListing(),
              fullscreenDialog: false));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => signupPage(response)));
      config.authenticator.setToken(response.token);
      config.UserData user = config.UserData(response.user);
    }
  }
}
