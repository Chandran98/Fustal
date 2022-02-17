import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fustal/src/config/app_service.dart';
import 'package:fustal/src/config/config.dart';
import 'package:fustal/src/config/routes.dart';
import 'package:fustal/src/constants/constants.dart';
import 'package:fustal/src/providers/auth_provider.dart';
import 'package:fustal/src/utils/Messenger.dart';
import 'package:provider/provider.dart';

class Signinscreen extends StatefulWidget {
  const Signinscreen({Key? key}) : super(key: key);

  @override
  State<Signinscreen> createState() => _SigninscreenState();
}

class _SigninscreenState extends State<Signinscreen> {
  // final GlobalKey _scaffoldkey = GlobalKey<ScaffoldState>();
  final formkey = GlobalKey<FormState>();

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool obsecuretext = true;
  bool signinStarted = false;
  bool signinCompleted = false;
  bool obscureText = false;
  Icon lockicon = const Icon(CupertinoIcons.lock_open_fill);
  late String email;
  late String password;

  signinwithemailpassword() async {
    final Authprovider authprovider =
        Provider.of<Authprovider>(context, listen: false);
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      await Appservice().connection().then((internet) {
        if (internet == false) {
          shortmessenger(context, "No Internet connection");
        } else {
          setState(() {
            signinStarted = true;
          });
          authprovider.signinwithemail(email, password).then((value) async {
            if (authprovider.haserror == false) {
              authprovider
                  .savetofirebase()
                  // .then((value) => authprovider
                  //     .savedatalocalDB()
                  .then((value) => authprovider.setSignIn().then((value) {
                        setState(() {
                          signinCompleted = true;
                        });
                        Navigator.pushNamed(context, mainscreenroute);
                      }));
            } else {
              setState(() {
                signinStarted = false;
              });
              shortmessenger(context, authprovider.errorcode);
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formkey,
        child: Column(
          children: [
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
            spacer10,
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {Navigator.pushNamed(context, forgotpasswordroute);},
                  child: Text(
                    'forgot password?',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
            ),
            spacer20,
            InkWell(
              onTap: () {
                signinwithemailpassword();
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
                child: signinStarted == false
                    ? const Center(
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      )
                    : signinCompleted == false
                        ? const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.transparent,
                              color: white,
                            ),
                          )
                        : const Center(
                            child: Text('sign up successful!',
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
            spacer20
          ],
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
