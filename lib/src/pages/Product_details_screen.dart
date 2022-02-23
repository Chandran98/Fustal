import 'package:flutter/material.dart';
import 'package:fustal/src/models/Products_model.dart';


class Productdetails extends StatefulWidget {
  final Products data;
  final String?tag;
  Productdetails({required this.data,required this.tag});

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}