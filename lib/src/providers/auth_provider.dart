import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authprovider extends ChangeNotifier {
  GoogleSignIn gsignin = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  String? _name, _uid, _email, _image, _timestamp, _signinprovider;
  bool _haserror = false;
  get haserror => _haserror;
  String? _errorcode;
  get errorcode => _errorcode;
  get name => _name;

  get email => _email;
  get image => _image;
  get uid => _uid;

  Future openaccountwithgoogle() async {
    final GoogleSignInAccount? googleuser = await gsignin.signIn();
    if (googleuser != null) {
      try {
        final GoogleSignInAuthentication googleAuth =
            await googleuser.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        User user = (await auth.signInWithCredential(authCredential)).user!;
        _name = user.displayName;
        _email = user.email;
        _uid = user.uid;
        _signinprovider = "google";
        _haserror = false;
        notifyListeners();
      } catch (e) {
        _haserror = true;
        _errorcode = e.toString();
        notifyListeners();
      }
    }
  }

  Future signUpwithemail(username, useremail, userpassword) async {
    try {
      final User user = (await auth.createUserWithEmailAndPassword(
              email: useremail, password: userpassword))
          .user!;
      await user.getIdToken();
      _name = username;
      _email = useremail;
      _uid = uid;
      _signinprovider = "email & password";
      _haserror = false;
    } catch (e) {
      _haserror = true;
      _errorcode = e.toString();
      notifyListeners();
    }
  }

  Future signinwithemail(useremail, userpassword) async {
    try {
      User user = (await auth.signInWithEmailAndPassword(
              email: useremail, password: userpassword))
          .user!;
      assert(user != null);
      await user.getIdToken();
      final User currentuser = auth.currentUser!;
      _uid = currentuser.uid;
      _signinprovider = "email & password";
      _haserror = false;
      notifyListeners();
    } catch (e) {
      _haserror = true;
      _errorcode = e.toString();
      notifyListeners();
    }
  }

  Future<bool> checkuserexists() async {
    final DocumentSnapshot snapshot =
        await firestore.collection("users").doc(_uid).get();

    if (snapshot.exists) {
      print("User exists");
      return true;
    } else {
      return false;
    }
  }

  Future savetofirebase() async {
    DocumentReference reference = await firestore.collection("users").doc(_uid);
    var userdata = {
      "name": _name,
      "email": _email,
      "uid": _uid,
      "timestamp": _timestamp,
      "loved items": [],
      "bookmark": []
    };
    await reference.set(userdata);
  }

  Future getuserdata(uid) async {
    await firestore
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot value) {
      _uid = value["uid"];
      _name = value["name"];
      _email = value["email"];
      // _uid = value["uid"];
    });
    notifyListeners();
  }

  Future gettimestamp() async {
    DateTime now = DateTime.now();
    String _timestamp = DateFormat("yyyyMMdd").format(now);
    _timestamp = _timestamp;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

  void checkSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _isSignedIn = sp.getBool('signed_in') ?? false;
    notifyListeners();
  }

  Future savedatalocalDB() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString("name", _name!);
    await preferences.setString("email", _email!);

    await preferences.setString("uid", _uid!);
    await preferences.setString('sign_in_provider', _signinprovider!);
    // notifyListeners();
  }

  Future getdatafromlocalDB() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _name = preferences.getString("name");
    _email = preferences.getString("email");
    _uid = preferences.getString("uid");
    _signinprovider = preferences.getString('sign_in_provider');
    notifyListeners();
  }

  Future usersignout() async {
    if (_signinprovider == "email") {
      await auth.signOut();
    } else {
      await gsignin.signOut();
      await auth.signOut();
    }
  }

  Future aftersignout() async {
    await usersignout().then((value) {
      cleardata();
      _isSignedIn= false;
      
    });
  }
  cleardata()async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.clear();
  }
}
