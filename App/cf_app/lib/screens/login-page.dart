import 'package:flutter/material.dart';
import '../palatte.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/background-image.dart';
import '../widgets/password-input.dart';
import '../widgets/rounded-button.dart';
import '../widgets/text_input.dart';
import "../widgets/sign-in-page.dart";

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.white,
          body: signIn_Page(),
        ),
      ],
    );
  }
}
