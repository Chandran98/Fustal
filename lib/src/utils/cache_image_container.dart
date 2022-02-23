import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Customcacheimage extends StatelessWidget {
  final String imageurl;
  final double radius;
  // final bool? circularshape;

  const Customcacheimage(
      {Key? key,
      required this.imageurl,
      required this.radius,
      // required this.circularshape
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
          // bottomLeft: Radius.circular(circularshape == false ? 0 : radius),
          // bottomRight: Radius.circular(circularshape == false ? 0 : radius),
        ),
        child: CachedNetworkImage(
            imageUrl: imageurl,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            placeholder: (_, url) => Container(
                  color: Colors.grey[300],
                ),
            errorWidget: (_, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                )));
  }
}
