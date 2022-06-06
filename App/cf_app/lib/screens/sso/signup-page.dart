// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import '../../palatte.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/background-image.dart';
import "../../widgets/ssoTextField.dart";
// import "../../widgets/ssotogglebtns.dart";
import "./model.dart";
import 'package:http/http.dart' as http;

class signupPage extends StatefulWidget {
  var request;
  signupPage(this.request);

  @override
  State<signupPage> createState() => _signupPageState(this.request);
}

class _signupPageState extends State<signupPage> {
  // TextEditingController nameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  var request;
  _signupPageState(this.request);
  User model = User();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackgroundImage(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(30),
                    child: const Text(
                      'Crowd Funding SignUp Page',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                // Container(
                //   padding: const EdgeInsets.all(30),
                //   child: ssoToggleButtons(),
                // ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'First Name',
                      htext: "John",
                      onSaved: (String? value) {
                        model.firstName = value;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'Last Name',
                      htext: "Doe",
                      onSaved: (String? value) {
                        model.lastName = value;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'Email',
                      htext: request.email,
                      onSaved: (String? value) {
                        model.email = value;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'Phone Number',
                      htext: '0300-1234567',
                      onSaved: (String? value) {
                        model.phone = value;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'Address',
                      htext: 'Full Address',
                      onSaved: (String? value) {
                        model.address = value;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'City',
                      htext: 'Karachi',
                      onSaved: (String? value) {
                        model.city = value;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'Postal Code',
                      htext: '12345',
                      onSaved: (String? value) {
                        model.postCode = value;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'Country',
                      htext: 'Pakisatn',
                      onSaved: (String? value) {
                        model.country = value;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'Zone',
                      htext: 'East',
                      onSaved: (String? value) {
                        model.zone = value;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'Bank Account Number',
                      htext: '',
                      onSaved: (String? value) {
                        model.bankAccountNumber = value;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'Bank Name',
                      htext: 'Alfalah',
                      onSaved: (String? value) {
                        model.bankName = value;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'Company',
                      htext: 'TPS WorldWide',
                      onSaved: (String? value) {
                        model.company = value;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: ssoTextField(
                      name: 'City',
                      htext: '1234567890123',
                      onSaved: (String? value) {
                        model.city = value;
                      }),
                ),
                // Container(
                //   padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                //   child: ssoTextField(
                //       name: 'Role',
                //       htext: 'Creator or Donator',
                //       onSaved: (String? value) {
                //         model.city = value;
                //       }),
                // )
                // ,
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                  child: RaisedButton(
                      color: Colors.white70,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onPressed: () async {
                        String jsonUser = jsonEncode(model);
                        final response = await http
                            .post(Uri.parse('http://192.168.1.3:3000/signup'),
                                headers: <String, String>{
                                  'Content-Type': 'application/json'
                                  // 'Authorization': 'Bearer ' + request.token
                                },
                                body: jsonUser)
                            .then((http.Response response) {
                          print("Response status: ${response.statusCode}");
                          print("Response body: ${response.contentLength}");
                          print(response.headers);
                          print(response.request);
                        });
                        if (response.statusCode == 200) {
                          return;
                        } else {
                          throw Exception('Failed to sign up User');
                        }
                      }),
                ),
                // Container(
                //     // height: 50,
                //     // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                //     child: ElevatedButton(
                //   child: const Text('GO !'),
                //   onPressed: () {
                //     print(nameController.text);
                //     print(passwordController.text);
                //   },
                // )),
              ]),
        )),
      )
    ]);
  }
}

// class Resp {
//   final bool userExists;
//   const Resp({required this.userExists});
//   factory Resp.fromJson(Map<String, dynamic> json) {
//     return Resp(userExists: json['userExists']);
//   }
// }
