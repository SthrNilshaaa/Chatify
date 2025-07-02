// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AppTopBar extends StatelessWidget {
  String titleBar;
  Widget? primaryaction;
  Widget? secondryAction;
  double? fontssize;
  AppTopBar(
    this.titleBar, {
    super.key,
    this.primaryaction,
    this.secondryAction,
    this.fontssize,
  });

  late double _deviceHigth;

  late double _deviceWigth;

  @override
  Widget build(BuildContext context) {
    _deviceHigth = MediaQuery.of(context).size.height;
    _deviceWigth = MediaQuery.of(context).size.width;
    return Container(
      height: _deviceHigth * 0.1,
      width: _deviceWigth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (secondryAction != null) secondryAction!,
          _titleBar(),
          if (primaryaction != null) primaryaction!,
        ],
      ),
    );
  }

  Widget _titleBar() {
    return GradientText(
      titleBar,
      overflow: TextOverflow.ellipsis,
      colors: const [Colors.blue, Colors.red, Colors.purple],
      style: GoogleFonts.sansita(fontSize: fontssize, fontWeight: FontWeight.bold),
    );
  }
}
