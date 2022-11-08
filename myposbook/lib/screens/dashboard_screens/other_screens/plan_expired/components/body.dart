import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myposbook/constants.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanExpiredBody extends StatelessWidget {
  const PlanExpiredBody({Key? key}) : super(key: key);

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch =
        Uri(scheme: 'https', host: 'myposbook.com.ng', path: '/plans');
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.1,
          horizontal: screenWidth * 0.05,
        ),
        child: Column(
          children: [
            Image.asset('lib/assets/icons/stopwatch.png'),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Text(
              'Whoops, Your Subscription Has Expired',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenHeight * 0.04,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Text(
              'Kindly Reactivate your Account to continue using my posbook',
              textAlign: TextAlign.center,
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: screenHeight * 0.022,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.065,
              child: ElevatedButton(
                onPressed: () async {
                  _launchInBrowser(toLaunch);
                },
                child: Text(
                  'Reactivate My Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // fontSize: screenHeight * 0.05,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.058,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                onPressed: () async {
                  FlutterSecureStorage storage = FlutterSecureStorage();
                  await storage.deleteAll();

                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushNamed(context, '/welcome_screen');
                },
                child: Text(
                  'LOGOUT',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
