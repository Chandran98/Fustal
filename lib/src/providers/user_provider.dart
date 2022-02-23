import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:fustal/src/models/user_model.dart';

class Userprovider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var currentdata;
  void getuserdata() async {
    UserModel userModel;
    var userdata =
        await firestore.collection("users").doc(auth.currentUser!.uid).get();
    if (userdata.exists) {
      userModel = UserModel(
          userEmail: userdata.get("email"),
          // userImage: userdata.get("image"),
          userName: userdata.get("name"),
          // userUid: userdata.get("uid")
          );
      currentdata = userModel;
      notifyListeners();
    }
  }

 UserModel get currentuserdata => currentdata;
}
