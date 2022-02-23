import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fustal/src/config/config.dart';
import 'package:fustal/src/constants/constants.dart';
import 'package:fustal/src/providers/banners_provider.dart';
import 'package:fustal/src/providers/theme_provider.dart';
import 'package:fustal/src/widgets/banners/Banner_card.dart';
import 'package:provider/src/provider.dart';

class Bannerplate extends StatefulWidget {
  Bannerplate({Key? key}) : super(key: key);

  @override
  State<Bannerplate> createState() => _BannerplateState();
}

class _BannerplateState extends State<Bannerplate> {
  int listindex = 0;
  @override
  Widget build(BuildContext context) {
    Bannerprovider bannerprovider = context.watch<Bannerprovider>();

    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
          height: 250,
          width: width,
          child: PageView.builder(itemBuilder: (_, index) {
            if (bannerprovider.data.isEmpty) {
              if (bannerprovider.hasdata == false) {
                return Emptycontent();
              } else {
                return Container();
              }
            }
            return Bannercard(
                d: bannerprovider.data[index], herotag: "Banners$index");
          }),
        ),
        spacer10,
        Center(
          child: DotsIndicator(
            dotsCount:
                bannerprovider.data.isEmpty ? 5 : bannerprovider.data.length,
            position: listindex.toDouble(),
            decorator: DotsDecorator(
              color: Colors.black26,
              activeColor: Theme.of(context).primaryColorDark,
              spacing: const EdgeInsets.only(left: 6),
              size: const Size.square(5.0),
              activeSize: const Size(20.0, 4.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
        )
      ],
    );
  }
}

class Emptycontent extends StatelessWidget {
  const Emptycontent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: context.watch<Themeprovider>().darktheme == false
              ? CustomColor().loadingColorLight
              : CustomColor().loadingColorDark),
      child: const Center(
        child: Text("No Contents found!"),
      ),
    );
  }
}
