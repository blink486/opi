import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class FirebaseDynamicLinkService {
  static Future<String> createDynamicLinkService(String surveyId) async {
    String _linkMessage;

    // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://opinzy.page.link',
      // link: Uri.parse('https://www.opinzy.com/surveyId?id=$surveyId'),
      link: Uri.parse('https://opinzy.page.link/surveyId?id=$surveyId'),
      androidParameters: const AndroidParameters(
        //  fallbackUrl: Uri.parse('https://www.bbc.co.uk'),
        // //default location if your App is not in Appstore yet
        packageName: 'com.example.moodclicks',
        minimumVersion: 1,
      ),
      // iosParameters: const IOSParameters(
      //   bundleId: 'io.invertase.testing',
      //   minimumVersion: '0',
      // ),
    );
    //  final Uri uri = await dynamicLinks.buildLink(parameters);
    Uri url;
    // if (short) {
    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    url = shortLink.shortUrl;
    // } else {
    //   uri = uri = await dynamicLinks.buildLink(parameters);
    // setState(() {
    //   _linkMessage = url.toString();
    //   _isCreatingLink = false;
    // });

    // print(_linkMessage);
    // uri = await dynamicLinks.buildLink(parameters);

    // }
//   static Future<void> initDynamicLink() async {
//     dynamicLinks = FirebaseDynamicLinks.instance;
//     dynamicLinks.onLink.listen((dynamicLinkData) {
// //OnSuccess Here
//     }).onError((error) {
// //onError Here
//     });
//   }
    _linkMessage = url.toString();
    print('Message link $_linkMessage');
    return _linkMessage;
  }
}
