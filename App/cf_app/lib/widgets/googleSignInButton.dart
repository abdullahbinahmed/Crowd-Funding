import '../widgets/logInWebview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../global.dart' as config show logInRoute;

final storage = FlutterSecureStorage();

class googleSignInButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _googleSignInButton();
  }
}

class _googleSignInButton extends State<googleSignInButton> {
  late WebViewController _controller;
  inform() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LogInWebView(config.logInRoute)));
  }

  Widget build(BuildContext context) {
    return SignInButton(Buttons.Google, onPressed: inform);
  }
}
