import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fustal/src/config/config.dart';
import 'package:fustal/src/constants/constants.dart';
import 'package:fustal/src/pages/Boarding_screen.dart';
import 'package:fustal/src/providers/auth_provider.dart';
import 'package:fustal/src/providers/theme_provider.dart';
import 'package:fustal/src/widgets/List_tile_widget.dart';
import 'package:provider/provider.dart';

class Settingscreen extends StatelessWidget {
  const Settingscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<Themeprovider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: [
            IconButton(
                onPressed: () {
                  theme.toggletheme();
                },
                icon: Icon(CupertinoIcons.moon_stars))
          ],
        ),
        body:
            // Center(
            //     child: SwitchListTile(
            //         value: Provider.of<Themeprovider>(context).darktheme,
            //         onChanged: (active) {
            //           Provider.of<Themeprovider>(context, listen: false)
            //               .toggletheme();
            //         })),

            ListView(
          padding: EdgeInsets.fromLTRB(15, 20, 20, 50),
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Userprofile(),
            const Text(
              "General Settings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            spacer20,
            Listtilewidget(
              color: Colors.blueGrey,
              ontap: () {},
              icon: FeatherIcons.bookmark,
              title: 'Bookmarks',
            ),
            ListTile(
                title: Text('Dark mode'),
                leading: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(CupertinoIcons.moon_stars,
                      size: 20, color: Colors.white),
                ),
                trailing: Switch(
                    activeColor: Theme.of(context).primaryColor,
                    value: Provider.of<Themeprovider>(context).darktheme,
                    onChanged: (active) {
                      Provider.of<Themeprovider>(context, listen: false)
                          .toggletheme();
                    })),
            const Divider(
              height: 3,
            ),
            ListTile(
                title: Text('Get notification'),
                leading: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(CupertinoIcons.bell,
                      size: 20, color: Colors.white),
                ),
                trailing: Switch(
                    activeColor: Theme.of(context).primaryColor,
                    value: Provider.of<Themeprovider>(context).darktheme,
                    onChanged: (active) {
                      // Provider.of<Themeprovider>(context, listen: false)
                      //     .toggletheme();
                    })),
            const Divider(
              height: 3,
            ),
            Listtilewidget(
              color: Colors.blueAccent,
              ontap: () {},
              icon: FeatherIcons.headphones,
              title: 'Contact us',
            ),
            Listtilewidget(
              color: Colors.pinkAccent,
              ontap: () {},
              icon: FeatherIcons.globe,
              title: 'Language',
            ),
            Listtilewidget(
              color: Colors.orangeAccent,
              ontap: () {},
              icon: FeatherIcons.star,
              title: 'Rate this app',
            ),
            Listtilewidget(
              color: Colors.redAccent,
              ontap: () {},
              icon: FeatherIcons.lock,
              title: 'Privacy policy',
            ),
            Listtilewidget(
              color: Colors.greenAccent,
              ontap: () {},
              icon: FeatherIcons.info,
              title: 'About us',
            ),
          ],
        ));
  }
}

class Userprofile extends StatelessWidget {
  const Userprofile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade500,
              ),
              spacer20,
              const Text(
                "data",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Listtilewidget(
          title: "Email@gamil.com",
          color: Colors.deepPurpleAccent,
          icon: FeatherIcons.mail,
          ontap: () {},
        ),
        Listtilewidget(
            title: "Edit profile",
            color: Colors.blueAccent,
            ontap: () {},
            icon: FeatherIcons.edit3),
        Listtilewidget(
            title: "Log out",
            color: Colors.redAccent,
            ontap: () {
              logout(context);
            },
            icon: FeatherIcons.logOut),
        spacer20
      ],
    );
  }

  void logout(_) {
    showDialog(
        context: (_),
        builder: (_) {
          return AlertDialog(
            title: const Text("Do you want to Leave"),
            actions: [
              TextButton(
                  onPressed: () async {
                    await _
                        .read<Authprovider>()
                        .usersignout()
                        .then((value) => _.read<Authprovider>().aftersignout())
                        .then((value) {
                      Navigator.of(_).pop();
                      if (_.read<Themeprovider>().darktheme == true) {
                        _.read<Themeprovider>().toggletheme();
                      }
                      Navigator.pushReplacement(_,
                          MaterialPageRoute(builder: (_) => Boardingscreen()));
                    });
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Config().appcolor),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(_).pop();
                  },
                  child: Text(
                    "cancel",
                    style: TextStyle(color: Config().appcolor),
                  )),
            ],
          );
        });
  }
}
