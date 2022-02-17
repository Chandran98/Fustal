import 'package:flutter/material.dart';

class Appname extends StatelessWidget {
  double fontsize;
   Appname({required this.fontsize}) ;

  @override
  Widget build(BuildContext context) {
    return RichText(text:   TextSpan(
        text: 'Fus',   //first part
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: fontsize,
            fontWeight: FontWeight.w900,
            color: Colors.deepPurpleAccent),
        children: <TextSpan>[
          TextSpan(
              text: 'tal',  //second part
              style:
                  TextStyle(fontFamily: 'Poppins', color: Colors.orangeAccent)),
        ],
      ),);
  }
}