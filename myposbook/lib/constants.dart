import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

const APIUrlRoot = 'myposbook.com.ng';
List<String> listOfStates = [
  'Abuja',
  'Abia',
  'Adamawa',
  'Akwa Ibom',
  'Anambra',
  'Bauchi',
  'Bayelsa',
  'Benue',
  'Borno',
  'Cross River',
  'Delta',
  'Ebonyi',
  'Edo',
  'Ekiti',
  'Enugu',
  'Gombe',
  'Imo',
  'Jigawa',
  'Kaduna',
  'Kano',
  'Katsina',
  'Kebbi',
  'Kogi',
  'Kwara',
  'Lagos',
  'Nassarawa',
  'Niger',
  'Ogun',
  'Ondo',
  'Osun',
  'Oyo',
  'Plateau',
  'Rivers',
  'Sokoto',
  'Taraba',
  'Yobe',
  'Zamfara',
];

const brandColor = Color(0xff27142A);
const formBgColor = Color(0xffF5F5F5);

secureStorage() async {
  const storage = FlutterSecureStorage();

  Map<String, String> access_token = await storage.readAll();
  return access_token;
  // _token = access_token;
}

appBarReusable(title, context) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: brandColor,
      ),
    ),
    backgroundColor: Colors.grey[50],
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back,
        color: brandColor,
      ),
    ),
    elevation: 0.0,
  );
}

// URL Launcher

Future<void> launchInBrowser(Uri url) async {
  // Launch url in browser
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

// launching the actual route for browser
Uri toLaunch(String host, String path) =>
    Uri(scheme: 'https', host: host, path: path);

// launcher for email
// String? encodeQueryParameters(Map<String, String> params){
//   return params.entries.map((MapEntry<String, String> e) => '${}').join(&))
// }

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'support@myposbook.com.ng',
  query: encodeQueryParameters(<String, String>{
    'subject': '',
  }),
);

final Uri telLaunchUri = Uri(
  scheme: 'tel',
  path: '09033551708',
);
