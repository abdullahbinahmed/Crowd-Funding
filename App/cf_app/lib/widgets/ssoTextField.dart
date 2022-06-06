import 'package:flutter/material.dart';

class ssoTextField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? htext;
  final String? name;
  ssoTextField({
    Key? key,
    this.name,
    this.htext,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        onSaved: onSaved,
        decoration: InputDecoration(
          hintText: htext,
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
        ));
  }
}
