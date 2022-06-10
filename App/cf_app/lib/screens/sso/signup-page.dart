import 'dart:convert';
import 'package:flutter/material.dart';
import '../../widgets/background-image.dart';
import "../../widgets/ssoTextField.dart";
import "./model.dart";
import 'package:http/http.dart' as http;
import '../../global.dart' as config
    show signUpEndpoint, UserData, authenticator;
import './signin-reply.dart';

class signupPage extends StatefulWidget {
  var request;
  signupPage(this.request);

  @override
  State<signupPage> createState() => _signupPageState(this.request);
}

class _signupPageState extends State<signupPage> {
  var request;
  _signupPageState(this.request);
  User model = User();
  final _formKey = GlobalKey<FormState>();
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
                Container(
                    padding: const EdgeInsets.all(30),
                    child: Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          Container(
                            padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                            child: ssoTextField(
                                initialValue: request.firstname,
                                name: 'First Name',
                                onSaved: (String? value) {
                                  model.firstName = value;
                                }),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                            child: ssoTextField(
                                initialValue: request.lastname,
                                name: 'Last Name',
                                onSaved: (String? value) {
                                  model.lastName = value;
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
                                htext: '123456789',
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
                                name: 'Role',
                                htext: 'Creator/Donator',
                                onSaved: (String? value) {
                                  model.role = value;
                                }),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                            child: ssoTextField(
                                name: 'CNIC Number',
                                htext: '123456789',
                                onSaved: (String? value) {
                                  model.cnic = value;
                                }),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(45, 0, 45, 20),
                            child: RaisedButton(
                                color: Colors.white70,
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                onPressed: () async {
                                  model.email = request.email;
                                  _formKey.currentState?.save();
                                  String jsonUser = jsonEncode(model);
                                  final response = await http
                                      .post(Uri.parse(config.signUpEndpoint),
                                          headers: <String, String>{
                                            'Content-Type': 'application/json'
                                          },
                                          body: jsonUser)
                                      .then((http.Response jsonresponse) {
                                    Map<String, dynamic> respMap = json
                                        .decode(json.decode(jsonresponse.body));
                                    UserCollection response =
                                        UserCollection.fromJson(respMap);
                                    config.UserData User =
                                        config.UserData(response.user);
                                    config.authenticator
                                        .setToken(response.token);
                                  });
                                  if (response.statusCode == 200) {
                                    return;
                                  } else {
                                    throw Exception('Failed to sign up User');
                                  }
                                }),
                          ),
                        ])))
              ]),
        )),
      )
    ]);
  }
}
