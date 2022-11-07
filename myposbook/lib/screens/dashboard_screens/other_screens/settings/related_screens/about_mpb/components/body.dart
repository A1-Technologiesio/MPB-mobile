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
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              context,
            ),

            const Divider(),

            // 2
            aboutHeading(
              'Save Records More efficiently and Know your business State on time',
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              context,
            ),
            const Divider(),

            // 3
            aboutHeading(
              'Let your Other branches keep your records like normal, but with software.',
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              context,
            ),
            const Divider(),

            // go back button
            ElevatedButton(
              onPressed: () {},
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
