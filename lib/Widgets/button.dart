import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final String name;
  final Color Bcolor;
  final double height;
  final double width;
  final double textSize;
  final Function onPressed;
  Button(
      {required this.name,
      required this.height,
      required this.width,
      required this.onPressed,
      required this.textSize,
      required this.Bcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(height * 0.2), color: Bcolor),
      height: height,
      width: width,
      child: TextButton(
        onPressed:() => onPressed(),
        child: Text(
          name,
          style: TextStyle(
            fontSize: textSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
