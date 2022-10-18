import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';

class ComingSoonBody extends StatelessWidget {
  final header;
  final supportingText;
  final imagePath;
  const ComingSoonBody({
    Key? key,
    required this.header,
    required this.supportingText,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          SizedBox(
            height: screenHeight * 0.028,
          ),
          Text(
            header,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenHeight * 0.024,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
            child: Text(
              supportingText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey[700],
                height: screenHeight * 0.0018,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.014,
            ),
            child: Text(
              'COMING SOON',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenHeight * 0.03,
                color: brandColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
