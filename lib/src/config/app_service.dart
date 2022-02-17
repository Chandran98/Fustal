import 'dart:io';

class Appservice{
  Future<bool?>connection()async{
    bool? internet;
    try{
      final result= await InternetAddress.lookup("google.com");
      if(result.isNotEmpty&& result[0].rawAddress.isNotEmpty){
      print("online");
        internet= true;
      }
    }on SocketException catch(_){
      print("Offline");
        internet = false;
      }
      return internet;
  }
}