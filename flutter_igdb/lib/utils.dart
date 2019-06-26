import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class Utility {
  static launchURL(String url, bool forceSafari) async {
    if (await canLaunch(url)) {
      if (Platform.isIOS) {
        await launch(url, forceSafariVC: forceSafari);
      } else {
        await launch(url);
      }
    } else {
      throw 'Could not open $url';
    }
  }
}