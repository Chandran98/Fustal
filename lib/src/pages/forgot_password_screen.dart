import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fustal/src/constants/constants.dart';
import 'package:fustal/src/utils/Messenger.dart';

class Forgetpassword extends StatefulWidget {
  Forgetpassword({Key? key}) : super(key: key);

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  FirebaseAuth auth = FirebaseAuth.instance;
  GlobalKey scaffoldkey = GlobalKey<ScaffoldState>();
  final formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  String? email;

  void handlesubmit() {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      resetpassword(email);
    }
  }

  Future resetpassword(email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      openDialog(context, 'Reset Password',
          'An email has been sent to $email. \n\nGo to that link & reset your password.');
    } catch (errorcode) {
      openSnacbar(scaffoldkey,errorcode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      // backgroundColor: Theme.of(context).backgroundColor,
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
          child: ListView(
            children: <Widget>[
              spacer20,
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: IconButton(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.keyboard_backspace),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              const Text('Reset your password',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
              const Text('follow the simple steps',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey)),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: 'username@mail.com', labelText: 'Email Address'
                    //suffixIcon: IconButton(icon: Icon(Icons.email), onPressed: (){}),

                    ),
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.length == 0) return "Email can't be empty";
                  return null;
                },
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: appcolor),
                width: double.infinity,
                child: TextButton(
                    // style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.resolveWith(
                    //         (states) => Theme.of(context).primaryColor)),
                    child: Text(
                      'submit',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    onPressed: () {
handlesubmit();                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
