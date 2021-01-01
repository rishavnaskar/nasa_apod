import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Components {
  final Widget kCircularProgressIndicator = Center(
      child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  ));

  final TextStyle kTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'Montserrat',
      fontStyle: FontStyle.italic);

  final kAlertDialog = AlertDialog(
    title: Center(
        child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    )),
    backgroundColor: Colors.transparent,
  );
}
