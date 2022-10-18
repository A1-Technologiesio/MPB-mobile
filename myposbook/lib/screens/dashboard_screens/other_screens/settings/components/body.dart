import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/coming_soon/coming_soon_main.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
        ),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // account section
            settingsTitle('Account', context),
            settingsButton('lib/assets/images/settings/profile.png',
                'Profile Settings', context, null),

            TextButton(
              // switch
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'lib/assets/images/settings/image 15.png',
                        height: MediaQuery.of(context).size.height * 0.034,
                      ),
                      SizedBox(
                        width: screenWidth * 0.035,
                      ),
                      Text(
                        'Show/Hide Records',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: screenHeight * 0.02,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) {
                      print(value);
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
            settingsButton(
              'lib/assets/images/settings/password-lock.png',
              'Change Password',
              context,
              null,
            ),

            // services
            settingsTitle('Services', context),
            Badge(
              shape: BadgeShape.square,
              badgeContent: const Text(
                'Coming Soon',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              badgeColor: Colors.blue,
              position: BadgePosition.topEnd(),
              child: settingsButton(
                'lib/assets/images/settings/backup.png',
                'Monthly Backups',
                context,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComingSoonMain(
                      header: 'Backups & Reports',
                      supportingText:
                          'View your records in an easy to understand \n and interpret charts, So you visualize your \n businesses position anytime.',
                      imagePath: 'lib/assets/images/backups.png',
                    ),
                  ),
                ),
              ),
            ),
            settingsButton(
                'lib/assets/images/settings/password-lock.png',
                'Branch Accounts',
                context,
                () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComingSoonMain(
                          header: 'Branch Accounts',
                          supportingText:
                              'Save time by getting your records done for you \n Get the records from your branches in One place \n Just issue out the Login info and they do it for you.',
                          imagePath: 'lib/assets/images/save-time.png',
                        ),
                      ),
                    )),
            settingsButton('lib/assets/images/settings/subscriptions.png',
                'Subscriptions', context, null),

            // others
            settingsTitle('Others', context),

            settingsButton(
              'lib/assets/images/settings/image 16.png',
              'Help & Support',
              context,
              () {},
            ),
            settingsButton('lib/assets/images/settings/image 17.png',
                'About My POS Book', context, null),
            SizedBox(
              height: screenHeight * 0.03,
            ),

            // Logout button
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.058,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
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
            SizedBox(
              height: screenHeight * 0.01,
            ),

            // social media buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // facebook Icon
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.facebook,
                  ),
                ),

                // instagram Icon
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.instagram,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// settings Button
TextButton settingsButton(
    String imagePath, String buttonTitle, context, onpressed) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  return TextButton(
    onPressed: onpressed,
    child: Row(
      children: [
        Row(
          children: [
            Image.asset(
              imagePath,
              height: screenHeight * 0.035,
            ),
            SizedBox(
              width: screenWidth * 0.038,
            ),
            Text(
              buttonTitle,
              style: TextStyle(
                color: Colors.black,
                fontSize: screenHeight * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
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
