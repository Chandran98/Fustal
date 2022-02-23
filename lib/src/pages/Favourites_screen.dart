import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  Fetchdata? fetchdata;

  @override
  Widget build(BuildContext context) {
    // Mainstoresproductprovider mainprovidr =
    //     Provider.of<Mainstoresproductprovider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Text(fetchdata!.name),
          // Text(mainprovidr.productprice),
          // Container(
          //   height: 100,
          //   width: 100,
          //   child: Image.network(mainprovidr.productimage),
          // )
        ],
      ),
    );
  }
}

class Fetchdata {
  String name;
  FirebaseAuth auth = FirebaseAuth.instance;
  Fetchdata({required this.name});
  Future<void> fetchdata() async {
    await FirebaseFirestore.instance
        .collection("Products")
        .doc(auth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      name = documentSnapshot["productname"];
    });
  }
}
