import 'package:flutter/material.dart';
import 'package:myposbook/screens/dashboard_screens/dashboard_main/components/amount_display/amount_display_section.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/cashouts_records/components/record_period_pageview.dart';
import 'package:myposbook/screens/dashboard_screens/other_screens/shared_components/transaction_items.dart';

class CashoutRecordBody extends StatelessWidget {
  const CashoutRecordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
        child: ListView(
          children: [
            // Heading and go back button
            SizedBox(
              height: screenHeight * 0.12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cashout Records',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.03,
                    ),
                  ),
                ],
              ),
            ),

            //
            RecordButtonPageView(
              recordType: 'cashouts',
            ),
          ],
        ),
      ),
    );
  }
}
