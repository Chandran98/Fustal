import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Mainstoreproductmodel {
  String productname;
  String productimage;

  String productprice;
  Mainstoreproductmodel(
      {required this.productimage,
      required this.productname,
      required this.productprice});
}

