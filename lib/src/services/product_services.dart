import 'package:cloud_firestore/cloud_firestore.dart';

class PRoductservies {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  fetchproduct() async {
    await firestore.collection("Products").snapshots();
  }
}
