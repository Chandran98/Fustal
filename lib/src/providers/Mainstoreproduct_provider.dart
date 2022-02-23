import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fustal/src/models/mainstoreproduct_model.dart';

class Mainstoresproductprovider with ChangeNotifier {
  // late Mainstoreproductmodel mainstoreproductmodel;
  String? _productimage;
  String? _productname;
  String? _productprice;
  get productimage => _productimage;
  get productname => _productname;
  get productprice => _productprice;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  fetchproduct() async {
    await firestore.collection("Products").doc().get().then((value) async {
      _productname = value["productname"];
      _productimage = value["productimage"];
      _productprice = value["productprice"];
    });
    notifyListeners();
  }
}
