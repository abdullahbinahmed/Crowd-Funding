import 'package:flutter/material.dart';

class ssoTextField extends StatelessWidget {
  const ssoTextField({
    Key? key,
    @required this.name,
    @required this.htext,
    @required this.nameController,
  }) : super(key: key);

  final TextEditingController? nameController;
  final String? htext;
  final String? name;
  @override
  Widget build(BuildContext context) {
    return TextField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        controller: nameController,
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
