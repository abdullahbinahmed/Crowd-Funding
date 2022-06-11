import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecoratedFormTextField extends StatelessWidget {
  const DecoratedFormTextField({
    Key? key,
    required this.icon,
    required this.focusNode,
    required this.keyboardType,
    required this.hintText,
    required this.labelText,
    this.hasError = false,
    required this.validator,
    required this.maxLength,
    required this.controller,
    this.maxLines = 1,
    this.obscureText = false,
    this.counterText = '',
    // required this.suffix,
    //required this.inputFormatters,
    this.enabled = true,
  }) : super(key: key);

  final IconData icon;
  // final ImageIcon imageIcon;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final bool hasError;
  final FormFieldValidator<String> validator;
  final int maxLength;
  final int maxLines;
  // final List<TextInputFormatter> inputFormatters;
  final TextEditingController controller;
  final bool obscureText;
  final String counterText;
  // Widget suffix;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    // final suffixWidgets = <Widget>[];

    // suffixWidgets.add(
    //   Icon(
    //     Icons.error,
    //     color: hasError ? Colors.red : Colors.transparent,
    //   ),
    // );

    // if (suffix != null) {
    //   suffixWidgets.add(suffix);
    // }

    return ListTile(
        title: TextFormField(
          enabled: enabled,
          focusNode: focusNode,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            counterText: counterText,
            // suffixIcon: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: suffixWidgets,
            // ),
          ),
          maxLines: maxLines,
          validator: validator,
          maxLength: maxLength,
          controller: controller,
          obscureText: obscureText,
          // inputFormatters: inputFormatters,
        ),
        leading: Icon(icon));
  }
}
