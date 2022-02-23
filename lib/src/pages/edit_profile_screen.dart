import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fustal/src/config/app_service.dart';
import 'package:fustal/src/providers/auth_provider.dart';
import 'package:fustal/src/utils/Messenger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';

class Editprofilescreen extends StatefulWidget {
  Editprofilescreen({Key? key}) : super(key: key);

  @override
  State<Editprofilescreen> createState() => _EditprofilescreenState();
}

class _EditprofilescreenState extends State<Editprofilescreen> {
  String? name;
  String? email;
  String? imageurl;

  File? imagefile;
  var filename;
  bool loading = false;
  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();

  Future pickimage() async {
    ImagePicker picker = ImagePicker();
    var imagepicked = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);

    if (imagepicked != null) {
      setState(() {
        imagefile = File(imagepicked.path);
        filename = (imagefile!.path);
      });
    } else {
      shortmessenger(context, "Select a image");
    }
  }

  Future uploadimage() async {
    final Authprovider authprovider = context.read<Authprovider>();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("Profile pictures/${authprovider.uid}}");
    UploadTask uploadTask = reference.putFile(imagefile!);

    await uploadTask.whenComplete(() async {
      var _url = await reference.getDownloadURL();
      var _imageurl = _url.toString();

      setState(() {
        imageurl = _imageurl;
      });
    });
  }

  Future Updatedata() async {
    Authprovider authprovider = context.read<Authprovider>();
    await Appservice().connection().then((internet) async {
      if (internet == false) {
        shortmessenger(context, "No internet connection");
      } else {
        if (formkey.currentState!.validate()) {
          formkey.currentState!.save();
          setState(() {
            loading = true;
          });
          imagefile == null
              ? await authprovider
                  .updateuser(namecontroller.text, imageurl)
                  .then((value) {
                  shortmessenger(context, "Updated successfully");
                  setState(() {
                    loading = false;
                  });
                })
              : await uploadimage()
                  .then((value) =>
                      authprovider.updateuser(namecontroller.text, imageurl))
                  .then((value) {
                  shortmessenger(context, "Updated successfully");
                  setState(() {
                    loading = false;
                  });
                });
        }
      }
    });
  }

  // @override
  // void initState() {
  //   namecontroller.text=name!;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      // key: sca,
      appBar: AppBar(
        title: Text('edit profile'),
        
      ),
      body: ListView(
          padding: const EdgeInsets.all(25),
          children: <Widget>[
            InkWell(
                  child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey[300],
                    child: Container(
                    height: 120,
                    width: 120,
                    
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey[400]!
                        ),
                        
                        // color: Colors.grey[500],
                        shape: BoxShape.circle,
                        // image: DecorationImage(
                        //     image: (imagefile == null ? NetworkImage(imageurl!) : FileImage(imagefile!)) as ImageProvider<Object>,
                        //     fit: BoxFit.cover)
                        ),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          size: 30,
                          color: Colors.black,
                        )),
                  ),
                ),
                onTap: (){
                  pickimage();
                },
            ),

            SizedBox(height: 50,),
            Form(
              key: formkey,
              child: TextFormField(
              
              decoration: InputDecoration(
                hintText: 'enter new name',
              ),
              controller: namecontroller,
              validator: (value){
                if (value!.length == 0) return "Name can't be empty";
                return null;
              },
              
            )),

            SizedBox(height: 50,),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) => Theme.of(context).primaryColor),
                  textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
                    color: Colors.white
                  ))
                ),
                child: loading == true 
                  ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),)
                  : Text('update profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                onPressed: (){
                  Updatedata();
                },

                
              ),
            ),
            
          ],
        )
      
      
    );

  }
}
