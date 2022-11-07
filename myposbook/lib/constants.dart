import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
