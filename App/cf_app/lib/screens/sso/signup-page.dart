import 'dart:convert';
import 'package:flutter/material.dart';
import '../../widgets/ssoDropDownField.dart';
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
  String _myRoleDropDownResult = '';
  String _myBankNameDropDownResult = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Crowd Funding'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30),
              child: Text(
                'Signup Page',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).primaryColor),
              )),
          Container(
              padding: const EdgeInsets.all(30),
              child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ssoTextField(
                          initialValue: request.firstname,
                          type: TextInputType.name,
                          name: 'First Name',
                          onSaved: (String? value) {
                            model.firstName = value;
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ssoTextField(
                          initialValue: request.lastname,
                          type: TextInputType.name,
                          name: 'Last Name',
                          onSaved: (String? value) {
                            model.lastName = value;
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ssoTextField(
                          type: TextInputType.number,
                          name: 'Phone Number',
                          htext: '0300-1234567',
                          onSaved: (String? value) {
                            model.phone = value;
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ssoTextField(
                          type: TextInputType.streetAddress,
                          name: 'Address',
                          htext: 'Full Address',
                          onSaved: (String? value) {
                            model.address = value;
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ssoTextField(
                          type: TextInputType.text,
                          name: 'City',
                          htext: 'Karachi',
                          onSaved: (String? value) {
                            model.city = value;
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ssoTextField(
                          type: TextInputType.number,
                          name: 'Postal Code',
                          htext: '12345',
                          onSaved: (String? value) {
                            model.postCode = value;
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ssoTextField(
                          type: TextInputType.text,
                          name: 'Country',
                          htext: 'Pakisatn',
                          onSaved: (String? value) {
                            model.country = value;
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ssoTextField(
                          type: TextInputType.text,
                          name: 'Zone',
                          htext: 'East',
                          onSaved: (String? value) {
                            model.zone = value;
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ssoTextField(
                          type: TextInputType.number,
                          name: 'Bank Account Number',
                          htext: '123456789',
                          onSaved: (String? value) {
                            model.bankAccountNumber = value;
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: dropDownField(
                        titleText: 'Bank Name',
                        hintText: 'Alfalah',
                        value: (dynamic selected) {
                          _myBankNameDropDownResult = selected;
                        },
                        onSaved: (dynamic value) {
                          model.bankName = _myBankNameDropDownResult;
                        },
                        dataSource1: 'Bank of Punjab',
                        dataSource2: 'NIFT Test Bank',
                        dataSource3: 'Standard Chatered Bank',
                        dataSource4: 'Alfalah',
                        dataSource5: 'HBL',
                        dataSource6: 'NBP',
                        dataSource7: 'Al Habib',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ssoTextField(
                          type: TextInputType.text,
                          name: 'Company',
                          htext: 'TPS WorldWide',
                          onSaved: (String? value) {
                            model.company = value;
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: dropDownField(
                        titleText: 'Role',
                        hintText: 'Creator/Donator',
                        value: (dynamic selected) {
                          _myRoleDropDownResult = selected;
                        },
                        onSaved: (dynamic value) {
                          model.role = _myRoleDropDownResult;
                        },
                        dataSource1: 'Creator',
                        dataSource2: 'Donator',
                        dataSource3: 'Creator/Donator',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ssoTextField(
                          type: TextInputType.number,
                          name: 'CNIC Number',
                          htext: '123456789',
                          onSaved: (String? value) {
                            model.cnic = value;
                          }),
                    ),
                    Container(
                      child: ElevatedButton(
                          style: ButtonStyle(backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color.fromARGB(255, 110, 10, 126)
                                    .withOpacity(0.5);
                              }
                              return const Color.fromARGB(255, 110, 10,
                                  126); // Use the component's default.
                            },
                          )),
                          child: const Text('Submit'),
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
                              Map<String, dynamic> respMap =
                                  json.decode(json.decode(jsonresponse.body));
                              UserCollection response =
                                  UserCollection.fromJson(respMap);
                              config.UserData User =
                                  config.UserData(response.user);
                              config.authenticator.setAuthToken(response.token);
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
    ));
  }
}
