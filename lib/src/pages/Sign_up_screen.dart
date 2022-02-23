import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fustal/src/config/app_service.dart';
import 'package:fustal/src/config/config.dart';
import 'package:fustal/src/config/routes.dart';
import 'package:fustal/src/constants/constants.dart';
import 'package:fustal/src/providers/auth_provider.dart';
import 'package:fustal/src/utils/Messenger.dart';
import 'package:provider/provider.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({Key? key}) : super(key: key);

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  // final GlobalKey _scaffoldkey = GlobalKey<ScaffoldState>();
  final formkey = GlobalKey<FormState>();

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
String? name;
String? email;
String? password;

  bool signUpStarted = false;
  bool signUpCompleted = false;
  bool obscureText = false;
  Icon lockicon = const Icon(CupertinoIcons.lock_open_fill);

  Future singupwithemailpassword() async {
    Authprovider authprovider =
        Provider.of<Authprovider>(context, listen: false);
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      await Appservice().connection().then((internet) {
        if (internet == false) {
          shortmessenger(context, "No Internet connection");
        }
      });
    } else {
      setState(() {
        signUpStarted = true;
      });
    }
    authprovider.signUpwithemail(name, email, password).then((value) {
      if (authprovider.haserror == false) {
        authprovider
            .gettimestamp()
            .then((value) => authprovider.savetofirebase())
            // .then((value) => authprovider.usercount())
            // .then((value) => authprovider
            //     .savedatalocalDB()
            .then((value) => authprovider.setSignIn().then((value) {
                      setState(() {
                        signUpStarted = true;
                      });
                      Navigator.pushNamed(context, mainscreenroute);
                      _emailcontroller.clear();
                      _passwordcontroller.clear();
                      _namecontroller.clear();
                    })
                // )
                );
      } else {
        setState(() {
          signUpStarted = false;
        });
        // openSnacbar(_scaffoldkey, );
        shortmessenger(context, authprovider.errorcode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // key: _scaffoldkey,
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spacer20,
                  Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: IconButton(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(Icons.keyboard_backspace),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  spacer20,
                  // ignore: prefer_const_constructors
                  Text('Sign up',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w700)),
                  Text('follow the simple steps',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).secondaryHeaderColor)),
                  const SizedBox(
                    height: 60,
                  ),

                  TextFormField(
                    controller: _namecontroller,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter Name',
                      //prefixIcon: Icon(Icons.person)
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) return "Name can't be empty";
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  spacer20,

                  TextFormField(
                    controller: _emailcontroller,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: 'User@gmail.com',
                      labelText: 'Email Address',
                      //prefixIcon: Icon(Icons.person)
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return ("Email can't be empty");
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  spacer20,
                  TextFormField(
                    controller: _passwordcontroller,
                    obscureText: obscureText,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              hidepassword();
                            },
                            icon: lockicon)
                        //prefixIcon: Icon(Icons.person)
                        ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return ("Password can't be empty");
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  spacer50,
                  InkWell(
                    onTap: () {
                      singupwithemailpassword();
                    },
                    borderRadius: BorderRadius.circular(0),
                    child: Container(
                      height: 50,
                      width: 320,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Config().appcolor),

                      // style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.resolveWith(
                      //         (states) => Theme.of(context).primaryColor)),
                      child: signUpStarted == false
                          ? const Center(
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            )
                          : signUpStarted == false
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    color: white,
                                  ),
                                )
                              : const Center(
                                  child: Text('Sign in successful!',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                ),
                      // onPressed: () {
                      //   // singupwithemailpassword();
                      // }
                    ),
                  ),
                  spacer10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('already have an account?'),
                      TextButton(
                        child: Text(
                          'sign in',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void hidepassword() {
    if (obscureText == true) {
      setState(() {
        obscureText = false;
        lockicon = const Icon(CupertinoIcons.lock_open);
      });
    } else {
      setState(() {
        obscureText = true;
        lockicon = const Icon(CupertinoIcons.lock_shield);
      });
    }
  }
}
