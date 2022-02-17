import 'dart:io';

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
}
