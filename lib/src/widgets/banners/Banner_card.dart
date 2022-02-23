import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fustal/src/constants/constants.dart';
import 'package:fustal/src/models/Products_model.dart';
import 'package:fustal/src/pages/Product_details_screen.dart';
import 'package:fustal/src/utils/cache_image_container.dart';

class Bannercard extends StatelessWidget {
  final Products d;
  // ignore: prefer_typing_uninitialized_variables
  final herotag;
  // ignore: use_key_in_widget_constructors
  const Bannercard({required this.d, required this.herotag});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Productdetails(data: d, tag: herotag))),
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).shadowColor,
                            blurRadius: 10,
                            offset: const Offset(0, 3)),
                      ]),
                  child: Hero(
                      tag: herotag,
                      child: Customcacheimage(
                        imageurl: d.thumbnailImagelUrl.toString(),
                        radius: 5,
                      )),
                )
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 5),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurpleAccent.withOpacity(0.7)),
                      child: Text(
                        d.category!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Spacer(),
                    Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 6, bottom: 6),
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.black45),
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              Icons.favorite,
                              size: 20,
                              color: Colors.white,
                            ),
                            spacerw10,
                            Text(
                              d.loves.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            spacerw20
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                top: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  decoration: const BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        d.title!,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      spacer10,
                      Row(
                        children: <Widget>[
                          const Icon(CupertinoIcons.time,
                              size: 16, color: Colors.white),
                          spacer10,
                          Text(d.date!,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13))
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
