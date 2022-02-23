import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:fustal/src/models/Products_model.dart';

class Bannerprovider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Products> _data = [];
  List<Products> get data => _data;
  List bannerlist = [];
  bool _hasdata = true;
  bool get hasdata => _hasdata;

  Future<List> _bannerslist() async {
    final DocumentReference ref =
        firestore.collection("banners").doc("Banners_list");
    DocumentSnapshot snapshot = await ref.get();

    bannerlist = snapshot["contents"] ?? [];
    if (bannerlist.isNotEmpty) {
      List<int> a = bannerlist.map((e) => int.parse(e)).toList()..sort();
      List<String> b = a.take(10).toList().map((e) => e.toString()).toList();
      return b;
    } else {
      return bannerlist;
    }
  }

  Future getdata() async {
    _bannerslist().then((bannerlist) async {
      QuerySnapshot rawdata;
      rawdata = await firestore
          .collection("contents")
          .where("timestamp", whereIn: bannerlist)
          .limit(10)
          .get();

      List<DocumentSnapshot> _snap = [];
      _snap.addAll(rawdata.docs);
      _data = _snap.map((e) => Products.fromFirestore(e)).toList();
      _data.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
      if (_data.isEmpty) {
        _hasdata = false;
      } else {
        _hasdata = true;
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      _hasdata = false;
      notifyListeners();
    });
  }

  onrefresh() {
    bannerlist.clear();
    _data.clear();
    _hasdata = true;
    getdata();
    notifyListeners();
  }
}
