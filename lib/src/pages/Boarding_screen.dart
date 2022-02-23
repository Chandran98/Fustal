import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fustal/src/config/app_service.dart';
import 'package:fustal/src/config/config.dart';
import 'package:fustal/src/config/routes.dart';
import 'package:fustal/src/constants/constants.dart';
import 'package:fustal/src/pages/Home_screen.dart';
import 'package:fustal/src/pages/Main_screen.dart';
import 'package:fustal/src/pages/Sign_in_screen.dart';
import 'package:fustal/src/providers/auth_provider.dart';
import 'package:fustal/src/utils/Messenger.dart';
import 'package:fustal/src/utils/app_name.dart';
import 'package:provider/provider.dart';
import "package:rounded_loading_button/rounded_loading_button.dart";

class Boardingscreen extends StatefulWidget {
  // Boardingscreen({required this.tag});

  @override
  State<Boardingscreen> createState() => _BoardingscreenState();
}

class _BoardingscreenState extends State<Boardingscreen> {
  GlobalKey scaffoldkey = GlobalKey<ScaffoldState>();
  RoundedLoadingButtonController googlecontroller =
      RoundedLoadingButtonController();
  googlesigin() async {
    Authprovider authprovider =
        Provider.of<Authprovider>(context, listen: false);
    await Appservice().connection().then((hasinternet) async {
      if (hasinternet == false) {
        shortmessenger(context, "No Internet connection");
      } else {
        await authprovider.openaccountwithgoogle().then((_) {
          if (authprovider.haserror == true) {
            googlecontroller.reset();

            shortmessenger(context, "Something went wrong.Please try again");

            // openSnacbar(scaffoldkey, "Something went wrong.Please try again");
          } else {
            authprovider.checkuserexists().then((value) {
              if (value == true) {
                authprovider.getuserdata(authprovider.uid).then(
                    (value) => authprovider.savedatalocalDB().then((value) {
                          googlecontroller.success();
                          nextscreen();
                        }));
              } else {
                authprovider.gettimestamp().then((value) => authprovider
                    .savetofirebase()
                    .then((value) => authprovider
                        .savedatalocalDB()
                        .then((value) => authprovider.setSignIn().then((value) {
                              googlecontroller.success();
                              nextscreen();
                            }))));
              }
            });
          }
        });
      }
    });
  }

  nextscreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => MainScreen()));

    // ignore: unn
    // ecessary_null_comparison
//     if (widget.tag == null) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => HomeScreen()));
//     } else {
//  Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => MainScreen
//           ()));    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 280,
                // color: Colors.grey.shade200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text("Welcome To ",
                      //         style: TextStyle(
                      //             fontSize: 22,
                      //             fontWeight: FontWeight.w500,
                      //             color:
                      //                 Theme.of(context).secondaryHeaderColor),),
                      Appname(fontsize: 35),
                    ],
                  ),
                ),
              ),
              const Signinscreen(),
              // spacer20,
              RoundedLoadingButton(
                child: Wrap(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      CupertinoIcons.game_controller,
                      size: 25,
                      color: Colors.white,
                    ),
                    spacerw20,
                    const Text(
                      'Sign In with Google',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  ],
                ),
                controller: googlecontroller,
                onPressed: () => googlesigin(),
                width: MediaQuery.of(context).size.width * 0.80,
                color: Config().appcolor, elevation: 0,
                //borderRadius: 3,
              ),
              spacer40,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?"),
                  spacerw10,
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, signuproute);
                      },
                      child: Text(
                        "Create one",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                ],
              ),
              spacer40,
            ],
          ),
        ),
      ),
    );
  }
}
