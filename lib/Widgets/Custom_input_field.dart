import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final Function(String) onSaved;
  final String hintText;
  final String name;
  final String regEx;
  final bool obscureText;
  CustomInputField({required this.onSaved, required this.hintText, required this.regEx, required this.obscureText, required this.name});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) => onSaved(value!),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      validator: (value) {
        return RegExp(regEx).hasMatch(value!) ? null : name;
      },
      decoration: InputDecoration(
          fillColor: Colors.grey[850],
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white)),
    );
  }
}
