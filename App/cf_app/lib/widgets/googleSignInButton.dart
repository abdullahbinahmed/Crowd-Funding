import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:cf_app/screens/sso/model.dart';
import 'package:flutter/material.dart';
import '../screens/sso/signup-page.dart';
import '../screens/sso/signin-reply.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
// import 'package:flutter_web_auth/flutter_web_auth.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class googleSignInButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _googleSignInButton();
  }
}

class _googleSignInButton extends State<googleSignInButton> {
  // late Future<Resp> futureResp;
  late WebViewController _controller;
  // final result = FlutterWebAuth.authenticate(
  // url: "http://192.168.1.3:3000/auth/google", callbackUrlScheme: "my-app");
  final String url = 'http://192.168.1.3:3000/auth/google';
  // if (Platform.isAndroid) WebView.platform = AndroidWebView();

  // @override
  // void initState() {
  //   super.initState();
  //   futureResp = fetchResponse();
  // }
  inform() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                YourWebView('http://192.168.1.3:3000/auth/google')));
  }

  Widget build(BuildContext context) {
    return SignInButton(Buttons.Google, onPressed: inform
        // return SafeArea(
        // FutureBuilder<Resp>(
        //     future: futureResp,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return Text(snapshot.data!.userExists.toString());
        //       } else if (snapshot.hasError) {
        //         return Text('${snapshot.error}');
        //       }
        //       return Text(snapshot.data!.userExists.toString());
        //     });
        // WebView(
        //   initialUrl: 'https://flutter.dev',
        // );
        // userAgent: "random",
        // javascriptMode: JavascriptMode.unrestricted,
        // onWebViewCreated: (controller) {
        //   this._controller = controller;
        // },

        // result;

        // if (await canLaunch(url)) {
        //   await launch(url);
        // }
        // },
        );
  }
}

class YourWebView extends StatefulWidget {
  String url;
  YourWebView(this.url);

  @override
  _YourWebViewState createState() => _YourWebViewState(this.url);
}

class _YourWebViewState extends State<YourWebView> {
  var _url;

  bool _dstReached = false;
  _YourWebViewState(this._url);
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
              // print(jsonDecode(resp));
              // print(response);
              SignUpNaviagtion(response);
            },
          );
        }));
  }

  void SignUpNaviagtion(response) {
    // if (!response.user.isExists) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => signupPage(response)));
    // }
  }
}

// class Album {
//   final String success;
//   final String token;
//   final String status;
//   final Array user

//   const Album({
//     required this.userId,
//     required this.id,
//     required this.title,
//   });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

// Future<Resp> fetchResponse() async {
//   final response =
//       await http.get(Uri.parse('http://192.168.1.3:3000/auth/google'));
//   if (response.statusCode == 200) {
//     return Resp.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to sign in User');
//   }
// }

// class Resp {
//   final bool userExists;
//   const Resp({required this.userExists});
//   factory Resp.fromJson(Map<String, dynamic> json) {
//     return Resp(userExists: json['userExists']);
//   }
// }
