import 'package:flutter/material.dart';
import '../../palatte.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/background-image.dart';
import "../../widgets/ssoTextField.dart";
import "../../widgets/ssotogglebtns.dart";
import "../../widgets/googleSignInButton.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackgroundImage(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(30),
                    child: const Text(
                      'Crowd Funding',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: const EdgeInsets.all(30),
                  child: googleSignInButton(),
                ),
                //   Container(
                //     padding: const EdgeInsets.all(30),
                //     child: ssoToggleButtons(),
                //   ),
                //   Container(
                //     padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                //     child: ssoTextField(
                //         name: 'Username',
                //         htext: 'Username',
                //         nameController: nameController),
                //   ),
                //   Container(
                //     padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                //     child: ssoTextField(
                //         name: 'Password',
                //         htext: 'Password',
                //         nameController: passwordController),
                //   ),
                //   Container(
                //     padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                //     child: TextButton(
                //       onPressed: () {
                //         //forgot password screen
                //       },
                //       child: const Text(
                //         'Forget Password',
                //       ),
                //     ),
                //   ),
                //   Container(
                //       // height: 50,
                //       // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                //       child: ElevatedButton(
                //     child: const Text('GO !'),
                //     onPressed: () {
                //       print(nameController.text);
                //       print(passwordController.text);
                //     },
                //   )),
              ]),
        ),
      )
    ]);
  }
}
