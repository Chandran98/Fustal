import 'package:flutter/material.dart';
import 'package:fustal/src/constants/constants.dart';
import 'package:fustal/src/themes/Themes.dart';
import 'package:fustal/src/utils/app_name.dart';
import 'package:fustal/src/widgets/title_board.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Icon(
                Icons.dashboard_rounded,
                size: 30,
              ),
              const Icon(
                Icons.notifications,
                size: 30,
              ),
            ],
          ),spacer20,
          // Titleboard(),
          Appname(fontsize: 40
          )
        ],
      ),
    );
  }
}

