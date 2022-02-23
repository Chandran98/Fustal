import 'dart:io';
import 'package:fustal/src/utils/Messenger.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class Appservice {
  Future<bool?> connection() async {
    bool? internet;
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // ignore: avoid_print
        print("online");
        internet = true;
      }
    } on SocketException catch (_) {
      // ignore: avoid_print
      print("Offline");
      internet = false;
    }
    return internet;
  }

  Future openlink (context,url)async{
    if(await urlLauncher.canLaunch(url)){
      urlLauncher.launch(url);
    }else{
      shortmessenger(context, "Can't open the link");
    }
  }
}
