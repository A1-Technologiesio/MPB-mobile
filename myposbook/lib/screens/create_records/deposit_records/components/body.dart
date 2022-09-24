import 'package:flutter/material.dart';
import 'package:myposbook/constants.dart';
import 'package:myposbook/screens/create_records/record_form.dart';

class CreateDepositRecordBody extends StatelessWidget {
  CreateDepositRecordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: ListView(
        children: [
          // image and intro text

          Container(
            width: screenWidth,
            height: mediaHeight * 0.36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                // bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage(
                  'lib/assets/images/naira-notes.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: mediaHeight * 0.04,
            ),
            child: Container(
              width: screenWidth,
              color: brandColor,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Cashout Record',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: mediaHeight * 0.035),
                    ),
                    SizedBox(
                      height: mediaHeight * 0.015,
                    ),
                    Text(
                      'Enter your record and press save.',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: mediaHeight * 0.018,
                      ),
                    ),
                    // forms
                    Padding(
                      padding: EdgeInsets.only(top: mediaHeight * 0.06),
                      child: RecordForm(
                        recordRoute: 'api/deposit/create/',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
