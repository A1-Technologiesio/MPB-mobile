import 'package:flutter/material.dart';

class AboutMPBBody extends StatelessWidget {
  const AboutMPBBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: SafeArea(
        child: ListView(
          children: [
            // main heading
            Text(
              'What is My POS Book',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenHeight * 0.030,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),

            Text(
                'My POS Book is a Leading accounting software for POS Businesses',
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.022,
                )),
            const Divider(),
            // body
            // 1
            aboutHeading(
              'Keep Track of your records in one place with simple to use steps',
              "Have all of your POS Business cashouts, Deposit & Transfer calculated for you in seconds, just input Amount, Charge & The terminal of choice, We sum all your records instantly both new and previous.",
              context,
            ),

            const Divider(),

            // 2
            aboutHeading(
              'Save Records More efficiently and Know your business State on time',
              "Gone are the days when you will have to wait till the end of the day to calculate your records. Just input amount, charge and select a terminal and Your records are kept instantly.",
              context,
            ),
            const Divider(),

            // 3
            aboutHeading(
              'Let your Other branches keep your records like normal, but with software.',
              "Coming Soon",
              context,
            ),
            const Divider(),

            // go back button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('I Understand'),
              style: ElevatedButton.styleFrom(),
            ),
          ],
        ),
      ),
    );
  }
}

aboutHeading(titleHeading, subHeading, context) {
  final screenHeight = MediaQuery.of(context).size.height;
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: screenHeight * 0.009,
    ),
    child: Column(
      children: [
        Text(
          titleHeading,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenHeight * 0.022,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.008,
        ),
        Text(
          subHeading,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    ),
  );
}
