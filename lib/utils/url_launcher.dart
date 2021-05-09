import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static void launchURL(String launchUrl) async {
    String url = launchUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
