import 'package:flutter/material.dart';
import 'package:fustal/src/themes/Themes.dart';

class Titleboard extends StatelessWidget {
  const Titleboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
       TextSpan(
        text: "Grab Your\n",
      ),
       TextSpan(
        text: "delicious meal !",
      )
    ]));
  }
}
