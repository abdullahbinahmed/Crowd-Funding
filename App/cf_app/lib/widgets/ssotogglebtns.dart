// import 'package:flutter/material.dart';
// import '../screens/sso/signup-page.dart';

// class ssoToggleButtons extends StatefulWidget {
//   const ssoToggleButtons({Key? key, @required this.pageName}) : super(key: key);
//   final String? pageName;
//   @override
//   State<ssoToggleButtons> createState() => _ssoToggleButtonsState();
// }

// class _ssoToggleButtonsState extends State<ssoToggleButtons> {
//   List<bool> _selections = List.generate(2, (_) => false);
//   // if (widget.pageName == 'LOGIN') {
//   //     Text('users');
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return ToggleButtons(
//       children: [Text('LOGIN'), Text('SIGNUP')],
//       isSelected: _selections,
//       onPressed: (int index) {
//         setState(() {
//           _selections[index] = !_selections[index];
//           if (widget.pageName == 'LOGIN' && _selections[index] == 1) {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const signupPage()));
//           } else {
//             Navigator.pop(context);
//           }
//         });
//       },
//       color: Colors.white30,
//       selectedColor: Colors.white,
//     );
//   }
// }
