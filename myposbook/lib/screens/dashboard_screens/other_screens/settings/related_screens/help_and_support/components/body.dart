import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';

class HelpAndSupportBody extends StatelessWidget {
  const HelpAndSupportBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
        ),
        child: ListView(
          children: [
            SupportButton('Get Support from Facebook', context, () {}),
            SupportButton('Get Support from Instagram', context, () {}),
            SupportButton('Get Support via Email', context, () {}),
            SupportButton('Get Support from Phone', context, () {}),
          ],
        ),
      ),
    );
  }
}

// settings Button
SupportButton(String buttonTitle, context, onpressed) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.0075),
    child: SizedBox(
      height: screenHeight * 0.07,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: brandColor,
        ),
        child: Row(
          children: [
            Text(
              buttonTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Padding settingsTitle(String title, context) => Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.035,
        bottom: MediaQuery.of(context).size.height * 0.015,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
