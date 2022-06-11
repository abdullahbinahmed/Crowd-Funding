import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class dropDownField extends StatelessWidget {
  final void Function(dynamic)? onSaved;
  final String? hintText;
  final String? titleText;
  final void Function(dynamic)? value;
  final String? dataSource1;
  final String? dataSource2;
  final String? dataSource3;
  final String? dataSource4;
  final String? dataSource5;
  final String? dataSource6;
  final String? dataSource7;

  dropDownField(
      {Key? key,
      this.onSaved,
      this.hintText,
      this.titleText,
      this.dataSource1,
      this.dataSource2,
      this.dataSource3,
      this.dataSource4,
      this.dataSource5,
      this.dataSource6,
      this.dataSource7,
      this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DropDownFormField(
      titleText: titleText,
      hintText: hintText,
      onSaved: onSaved,
      value: value,
      dataSource: [
        {"display": dataSource1, value: dataSource1},
        {"display": dataSource2, value: dataSource2},
        {"display": dataSource3, value: dataSource3},
        {"display": dataSource4, value: dataSource4},
        {"display": dataSource5, value: dataSource5},
        {"display": dataSource6, value: dataSource6},
        {"display": dataSource7, value: dataSource7},
      ],
    );
  }
}
